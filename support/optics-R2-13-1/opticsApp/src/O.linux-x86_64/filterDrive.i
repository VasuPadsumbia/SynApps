# 1 "../filterDrive.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../filterDrive.st"
program filterDrive("NAME=filterDrive, P=TEST:, R=filter:, NUM_FILTERS=8")
# 54 "../filterDrive.st"
option +r;

%%#include <string.h>
%%#include <math.h>
%%#include "chantler.h"
# 72 "../filterDrive.st"
int STATUS_BUSY;
assign STATUS_BUSY to "{P}{R}Status";
monitor STATUS_BUSY;


int NFILTERS;
assign NFILTERS to "{P}{R}NumFilters";
# 87 "../filterDrive.st"
int DEBUG;
assign DEBUG to "{P}{R}Debug";
monitor DEBUG;


double TRANSMISSION;
assign TRANSMISSION to "{P}{R}Transmission";


double TRANSMISSION_UP;
assign TRANSMISSION_UP to "{P}{R}TransmissionUp";


double TRANSMISSION_DOWN;
assign TRANSMISSION_DOWN to "{P}{R}TransmissionDown";


int FILTER_MASK;
assign FILTER_MASK to "{P}{R}FilterMask";


evflag EvFlgTRANSM_SETPT;
double TRANSM_SETPT;
assign TRANSM_SETPT to "{P}{R}TransmissionSetpoint";
monitor TRANSM_SETPT;
sync TRANSM_SETPT EvFlgTRANSM_SETPT;


evflag EvFlgFILTERMASK_SETPT;
int FILTERMASK_SETPT;
assign FILTERMASK_SETPT to "{P}{R}FilterMaskSetpoint";
monitor FILTERMASK_SETPT;
sync FILTERMASK_SETPT EvFlgFILTERMASK_SETPT;


int TRANSM_UP;
assign TRANSM_UP to "{P}{R}TransmissionStepUp";
monitor TRANSM_UP;


int TRANSM_DN;
assign TRANSM_DN to "{P}{R}TransmissionStepDown";
monitor TRANSM_DN;

evflag needRecalc;
evflag newEnergy;


double ENERGY;
assign ENERGY to "{P}{R}Energy";
monitor ENERGY;
sync ENERGY newEnergy;


string MSGE;
assign MSGE to "{P}{R}Message";


double FILTER_WAIT_TIME;
assign FILTER_WAIT_TIME to "{P}{R}WaitTime";


double TRANSM[32];
assign TRANSM to {};


double THICK[32];
assign THICK to {};
monitor THICK;
sync THICK needRecalc;


string MATER[32];
assign MATER to {};
monitor MATER;
sync MATER needRecalc;


int LOCK[32];
assign LOCK to {};
monitor LOCK;
sync LOCK needRecalc;


int SET[32];
assign SET to {};
monitor SET;


int ENBL[32];
assign ENBL to {};
monitor ENBL;
sync ENBL needRecalc;


int OUT[32];
assign OUT to {};


int OUTGET[32];
assign OUTGET to {};

evflag externalIO;
monitor OUTGET;
sync OUTGET externalIO;

char *name;
char *prefix;
char *record;
int changeFlag;
int doWait;
int nFltrs;
int nEnabled;
int nPerms;
int ind;
int indNow;
int fltrsInNow;
double transNow;
int indUp;
int fltrsInUp;
double transUp;
int indDown;
int fltrsInDown;
double transDown;
double trans;
int indMin;
double transMin;
int i;
int j;
int k;
int myAction;
int fltrsReq;
int fltrsSetpt;
char str[64];
double transMis[65536];
int fltrsIn[65536];
string buff0;
string buff1;





%{






static char *cvtToBin(char *buff,
                      int val,
                      int nBits)
{
  int i, nxtBit, nxtChar;

  nxtChar = 0;
  for (i = 0; i < nBits; i++) {
    nxtBit = 1 << (nBits - i - 1);
    if ((i != 0) && ((i & 0x0003) == 0)) buff[nxtChar++] = '.';

    if (val & nxtBit) {
      buff[nxtChar++] = '1';
      val &= ~nxtBit;
    }else {
      buff[nxtChar++] = '0';
    }
  }
  buff[nxtChar] = '\0';
  if (val != 0) {
    for (i = 0; i < nxtChar; i++) buff[i] = '*';
  }

  return buff;
}


static double calcTrans(double keV,
                        double thickness,
                        char *species,
                        int debug)
{
  int i, j;
  double mu, frac, absLen, transm;

  for(i=0; i<NUM_SPECIES; i++) {
    if (strcmp(filtermat[i].name, species) == 0) break;
  }
  if(i >= NUM_SPECIES) {
    if(debug) printf("Filter material '%s' not found\n", species);
    return(0.);
  }
  if(debug & 4) printf("  species = '%s', index = %d\n", species, i);
  if(debug & 4) printf("  density = %.4e gm/cm3, thickness = %.4e um\n",
      matdensity[i], thickness);
  if(debug & 4) printf("  energy = %.4e\n", keV);

  for(j=0; j<filtermat[i].numEntries; j++) {
    if (keV < filtermat[i].keV[j]) break;
  }
  if((j < 1) | (j >= filtermat[i].numEntries)) {
    if(debug) printf("Energy '%f' not found in filter data\n", keV);
    return(0.);
  }




  frac = (keV - filtermat[i].keV[j-1]) / (filtermat[i].keV[j] - filtermat[i].keV[j-1]);
  mu = filtermat[i].mu[j-1] + frac * (filtermat[i].mu[j] - filtermat[i].mu[j-1]);
  absLen = 1.0/(matdensity[i]*mu);
  absLen *= 1.e4;
  transm = exp(-(thickness/absLen));

  if(debug & 8){
    printf("  E1 = %.4e keV, mu1 = %.4e\n",
        filtermat[i].keV[j-1], filtermat[i].mu[j-1]);
    printf("  E2 = %.4e keV, mu2 = %.4e\n",
        filtermat[i].keV[j], filtermat[i].mu[j]);
    printf("  frac = %.4f, mu = %.4e\n", frac, mu);
  }

  if(debug & 4){
    printf("  attenuation length ='%.4e' um, transmission=%.4e\n", absLen, transm);
  }

  return(transm);
}

}%






  ss filterDrive {



    state start {
      when() {

        changeFlag = 1;


        epicsThreadSleep(1.0);


        name = macValueGet("NAME");
        prefix = macValueGet("P");
        record = macValueGet("R");
        sscanf(macValueGet("NUM_FILTERS"), "%d", &nFltrs);


        for(i = 0; i < nFltrs; i++) {
          sprintf(str, "%s%sFi%d:Thickness", prefix, record, i+1);
          pvAssign(THICK[i], str);
          sprintf(str, "%s%sFi%d:Material", prefix, record, i+1);
          pvAssign(MATER[i], str);
          sprintf(str, "%s%sFi%d:Transmission", prefix, record, i+1);
          pvAssign(TRANSM[i], str);
          sprintf(str, "%s%sFi%d:Lock", prefix, record, i+1);
          pvAssign(LOCK[i], str);
          sprintf(str, "%s%sFi%d:Set", prefix, record, i+1);
          pvAssign(SET[i], str);
          sprintf(str, "%s%sFi%d:Enable", prefix, record, i+1);
          pvAssign(ENBL[i], str);
          sprintf(str, "%s%sFi%d:Set", prefix, record, i+1);
          pvAssign(OUT[i], str);
          sprintf(str, "%s%sFi%d:OutGet", prefix, record, i+1);
          pvAssign(OUTGET[i], str);

        }

        NFILTERS = nFltrs;
        pvPut(NFILTERS);

        printf("%s: SNL program started for %s%s\n", name, prefix, record);
        printf("%s:   # of filters = %d\n", name, nFltrs);


        epicsThreadSleep(1.0);

      } state init
    }



    state init {

      when(pvConnectCount() == pvAssignCount()) {

        epicsThreadSleep(2.0);

        sprintf(MSGE, "Initialising ..."); pvPut(MSGE); strcpy(MSGE, "");
        efClear(EvFlgTRANSM_SETPT);
        TRANSM_UP = 0; pvPut(TRANSM_UP);
        TRANSM_DN = 0; pvPut(TRANSM_DN);
        efSet(needRecalc);
      } state waiting
    }



    state waiting {


      when(pvConnectCount() != pvAssignCount()) {
        printf ("%s: channel connection lost.\n", name);
      } state init


      when(efTestAndClear(newEnergy)) {
        if (DEBUG & 0x1) printf("%s: Energy change detected\n", name);
      } state update_filters


      when(efTestAndClear(needRecalc)) {
        if (DEBUG & 0x1) printf("%s: Configuration change detected\n", name);
      } state update_filters


      when(efTestAndClear(EvFlgTRANSM_SETPT)) {
        if(DEBUG & 0x1) printf("%s: transmission setpoint changed.\n", name);
        myAction = 0;
      } state action


      when(TRANSM_UP) {
        TRANSM_UP = 0;
        pvPut(TRANSM_UP);
        if(DEBUG & 0x1) printf("%s: step up.\n", name);
        myAction = 1;
      } state action


      when(TRANSM_DN) {
        TRANSM_DN = 0;
        pvPut(TRANSM_DN);
        if(DEBUG & 0x1) printf("%s: step down.\n", name);
        myAction = 2;
      } state action


      when(efTestAndClear(EvFlgFILTERMASK_SETPT)) {
        if(DEBUG & 0x1) printf("%s: filter mask setpoint changed.\n", name);
        myAction = 3;
      } state action


      when(STATUS_BUSY){
        if (DEBUG & 0x1) printf("%s: Busy record was set\n", name);
        changeFlag = 1;
      } state update_filters


      when (efTestAndClear(externalIO)) {
        if (DEBUG & 0x1) printf("%s: External IO event flag was set\n", name);
      } state update_filters

    }



    state update_filters {
      entry {
        if (DEBUG & 0x1) printf("%s: entering state: update_filters\n", name);
        pvPut(MSGE); strcpy(MSGE, "OK");
      }

      when(){


        for(i = 0; i < nFltrs; i++) {
          pvGet(OUTGET[i]);
          efClear(externalIO);
          pvGet(SET[i]);
          if (SET[i] != OUTGET[i]) {




            SET[i] = OUTGET[i];
            pvPut(SET[i]);
            sprintf(MSGE, "Filter state set by external agent.");
            pvPut(MSGE);
          }
        }


        transNow = 1.0;
        fltrsInNow = 0;
        nEnabled = 0;
        for(i = 0; i < nFltrs; i++) {

          if(DEBUG & 0x4){
            printf("%s: Calculating transmission for blade %d.\n", name, i);
          }
          TRANSM[i] = calcTrans(ENERGY, THICK[i], MATER[i], DEBUG);
          pvPut(TRANSM[i]);


          if(SET[i] && ENBL[i]){
            fltrsInNow |= (1 << i);
            transNow *= TRANSM[i];
          }
          if((LOCK[i] == 0) && ENBL[i]) {
            nEnabled += 1;
          }
        }

        TRANSMISSION = transNow; pvPut(TRANSMISSION);
        FILTER_MASK = fltrsInNow; pvPut(FILTER_MASK);


        if(nEnabled > 16){
          if(DEBUG & 0x1){
            printf("%s: ERROR: Too many filters unlocked (%d/%d).\n",
                name, nEnabled, 16);
          }
          sprintf(MSGE, "ERROR: Too many unlocked (%d/%d)", nEnabled, 16);
          pvPut(MSGE);
        }




        nPerms = 1 << nEnabled;
        for(i = 0; i < nPerms; i++){
          transMis[i] = 1.0;
          fltrsIn[i] = 0;
          k = 0;
          for(j = 0; j < nFltrs; j++){
            if(ENBL[j]){
              if(LOCK[j] == 1){
                if(SET[j]){

                  transMis[i] *= TRANSM[j];
                  fltrsIn[i] |= (1 << j);
                }
              } else {
                if(i & (1 << k)){
                  transMis[i] *= TRANSM[j];
                  fltrsIn[i] |= (1 << j);
                }
                k++;
              }
            }
          }
        }
        if(DEBUG & 0x2){
          printf("%s: <#-enabled>=%d, <#-permutations>=%d, transmission=%e\n",
              name, nEnabled, nPerms, transNow);
          for(i = 0; ((i < nPerms) && (i < 100)); i++){
            printf("  %s: %s    %e\n",
                cvtToBin(buff0, i, nEnabled),
                cvtToBin(buff1, fltrsIn[i], nFltrs),
                transMis[i]);
          }
        }


        indNow = -1;
        for(ind = 0; ind < nPerms; ind++) {
          if(transMis[ind] == transNow) indNow = ind;
        }
        if(indNow < 0){
          printf("ERROR: Could not find current filter index\n");
        }
        if(DEBUG & 0x2){
          printf("%s: Current index = %d\n", name, indNow);
        }


        indUp = -1;
        transUp = 10.0;
        for(ind = 0; ind < nPerms; ind++) {
          if( (transMis[ind] > (transNow * (1 + 1e-8))) &
              (transMis[ind] < transUp) ){
            transUp = transMis[ind];
            indUp = ind;
          }
        }
        if(transUp > 1.0){
          transUp = transNow;
          indUp = indNow;
        }
        fltrsInUp = fltrsIn[indUp];
        TRANSMISSION_UP = transUp;
        pvPut(TRANSMISSION_UP);
        if(DEBUG & 0x2){
          printf("%s: Filter up: index = %d, transm = %e\n",
           name, indUp, transUp);
        }


        indDown = -1;
        transDown = -1.0;
        for(ind = 0; ind < nPerms; ind++) {
          if( (transMis[ind] < (transNow * (1 - 1e-8))) &
              (transMis[ind] > transDown) ){
            transDown = transMis[ind];
            indDown = ind;
          }
        }
        if(transDown < 0.0){
          transDown = transNow;
          indDown = indNow;
        }
        fltrsInDown = fltrsIn[indDown];
        TRANSMISSION_DOWN = transDown;
        pvPut(TRANSMISSION_DOWN);
        if(DEBUG & 0x2){
          printf("%s: Filter down: index = %d, transm = %e\n",
              name, indDown, transDown);
        }


        if(changeFlag){
          if(DEBUG & 0x1) printf("%s: clearing busy record.\n", name);
          changeFlag = 0;

          STATUS_BUSY = 0;
          pvPut(STATUS_BUSY);
        }

      } state waiting
    }



    state action {

      when() {

        strcpy(MSGE, ""); pvPut(MSGE);


        changeFlag = 1;

        if(DEBUG & 0x1){
          sprintf(MSGE, "Action = %d", myAction); pvPut(MSGE);
          printf("Action = %d\n", myAction);

        }
        strcpy(MSGE, "");

        if(myAction == 0) {




          if(DEBUG & 0x1){
            printf("%s: Required transmission = %e\n", name, TRANSM_SETPT);
          }

          trans = -1.0;
          transMin = 1.0;
          for(k = 0; k < nPerms; k++) {
            if( (transMis[k] <= (TRANSM_SETPT)) &
                (transMis[k] > trans) ){
              ind = k;
              trans = transMis[k];
            }
            if(transMis[k] < transMin){
              transMin = transMis[k];
              indMin = k;
            }
          }
          if(trans < transMin){
            ind = indMin;
          }

          if(DEBUG & 0x1) {
            printf("%s: New filter index: %d\n", name, ind);
            printf("%s: Selected filters are: %s   Transmission = %e\n",
              name, cvtToBin(buff1, fltrsIn[ind], nFltrs), transMis[ind]);
          }

          if(transMis[ind] == transNow){
            if(DEBUG & 0x1) printf("NO CHANGE! Current settings are best.\n");
            strcpy(MSGE, "OK - No change");
            pvPut(MSGE);
          } else {
            strcpy(MSGE, "OK"); pvPut(MSGE);
          }

        } else if(myAction == 1){



          ind = indUp;
          if(transUp == transNow) {
            strcpy(MSGE, "NO CHANGE! Step unavailable.");
            pvPut(MSGE);
            if(DEBUG & 0x1) printf("%s: No more steps up available!\n", name);
          } else {
            strcpy(MSGE, "OK"); pvPut(MSGE);
          }
          if(DEBUG & 0x1){
            printf("%s: Next filter pattern is %s,  Transmission = %e\n",
            name, cvtToBin(buff1, fltrsIn[ind], nFltrs), transMis[ind]);
          }

        } else if(myAction == 2) {



          ind = indDown;
          if(transDown == transNow) {
            strcpy(MSGE, "NO CHANGE! Step unavailable.");
            pvPut(MSGE);
            if(DEBUG & 0x1) printf("%s: No more steps down available!\n", name);
          } else {
            strcpy(MSGE, "OK"); pvPut(MSGE);
          }
          if(DEBUG & 0x1){
            printf("%s: Next filter pattern is %s,  Transmission = %e\n",
            name, cvtToBin(buff1, fltrsIn[ind], nFltrs), transMis[ind]);
          }

        } else if(myAction == 3){


          fltrsSetpt = FILTERMASK_SETPT;


          if( (fltrsSetpt < 0) | (fltrsSetpt > ((1 << nFltrs) - 1)) ){
            ind = indNow;
     strcpy(MSGE, "ERROR! Invalid mask.");
            pvPut(MSGE);
            if(DEBUG & 0x1){
       printf("%s: ERROR! Invalid filter mask: %d\n", name, fltrsSetpt);
              printf("%s:   Valid masks are in the range (0 - %d)\n",
   name, ((1 << nFltrs) - 1));
            }
   } else {


            fltrsReq = 0;
            for(j = 0; j < nFltrs; j++){
              if(ENBL[j]){
                if(LOCK[j] == 1){
                  if(SET[j]){

                    fltrsReq |= (1 << j);
                  }
                } else {
                  fltrsReq |= (1 << j) & fltrsSetpt;
                }
              }
            }
            if(DEBUG & 0x1){
              printf("%s: Required filter mask: %x\n", name, fltrsSetpt);
              printf("%s: Adjusted filter mask: %x\n", name, fltrsReq);
            }

            ind = -1;
            for(i = 0; i < nPerms; i++) {
              if(fltrsIn[i] == fltrsReq) ind = i;
            }
            if(ind < 0) {
              printf("%s: Cannot find the requested filter pattern!\n", name);
              strcpy(MSGE, "ERROR! Filter Mask not found.");
              pvPut(MSGE);
            } else {
              strcpy(MSGE, "OK"); pvPut(MSGE);
            }

            if(DEBUG & 0x1){
              printf("%s: Next filter pattern is %s,  Transmission = %e\n",
              name, cvtToBin (buff1, fltrsIn[ind], nFltrs), transMis[ind]);
            }
          }
        }


        TRANSM_UP = 0; pvPut(TRANSM_UP);
        TRANSM_DN = 0; pvPut(TRANSM_DN);

      } state change_filters
    }


    state change_filters {
      when() {
        if(ind >=0){


          doWait = 0;
          for(j = 0; j < nFltrs; j++) {
            if(ENBL[j]){
              if(fltrsIn[ind] & (1 << j)) {
                if(SET[j] == 0) doWait = 1;
                SET[j] = 1; pvPut(SET[j]);
              }
            }
          }


          if(doWait){
            pvGet(FILTER_WAIT_TIME);
            epicsThreadSleep(FILTER_WAIT_TIME);
          }


          doWait = 0;
          for(j = 0; j < nFltrs; j++) {
            if(ENBL[j]){
              if((fltrsIn[ind] & (1 << j)) == 0) {
                if(SET[j] == 1) doWait = 1;
                SET[j] = 0; pvPut(SET[j]);
              }
            }
          }


          if(doWait){
            pvGet(FILTER_WAIT_TIME);
            epicsThreadSleep(FILTER_WAIT_TIME);
          }
        }
      } state waiting
    }
  }
