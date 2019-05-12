# 1 "../pf4.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/home/vasu/gcc-arm-8.2-2019.01-x86_64-arm-linux-gnueabi/arm-linux-gnueabi/libc/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../pf4.st"
# 17 "../pf4.st"
program pf4("name=pf4,P=,H=,B=,BP=,B1=,B2=,B3=,B4=,M=")

option +d;
option -c;
option +r;
option -w;

%%#include <stdio.h>
%%#include <math.h>
%%#include <string.h>
# 1 "../seqPVmacros.h" 1
# 28 "../pf4.st" 2

%%#include "chantler.h"
# 40 "../pf4.st"
int b1; assign b1 to "{BP}{B1}" ; monitor b1; evflag b1_mon; sync b1 b1_mon;
int b2; assign b2 to "{BP}{B2}" ; monitor b2; evflag b2_mon; sync b2 b2_mon;
int b3; assign b3 to "{BP}{B3}" ; monitor b3; evflag b3_mon; sync b3 b3_mon;
int b4; assign b4 to "{BP}{B4}" ; monitor b4; evflag b4_mon; sync b4 b4_mon;
double monoenergy; assign monoenergy to "{M}" ; monitor monoenergy; evflag monoenergy_mon; sync monoenergy monoenergy_mon;

int displayBit1; assign displayBit1 to "{P}{H}displayBit1{B}" ;
int displayBit2; assign displayBit2 to "{P}{H}displayBit2{B}" ;
int displayBit3; assign displayBit3 to "{P}{H}displayBit3{B}" ;
int displayBit4; assign displayBit4 to "{P}{H}displayBit4{B}" ;
double displayEnergy; assign displayEnergy to "{P}{H}displayEnergy" ;





int selectenergy; assign selectenergy to "{P}{H}useMono" ; monitor selectenergy; evflag selectenergy_mon; sync selectenergy selectenergy_mon;
double localenergy; assign localenergy to "{P}{H}E:local" ; monitor localenergy; evflag localenergy_mon; sync localenergy localenergy_mon;


double filterAl; assign filterAl to "{P}{H}filterAl" ;
double filterTi; assign filterTi to "{P}{H}filterTi" ;
double filterGl; assign filterGl to "{P}{H}filterGlass" ;





double trans; assign trans to "{P}{H}trans{B}" ;
double invtrans; assign invtrans to "{P}{H}invTrans{B}" ;
int debug_flag; assign debug_flag to "{P}{H}debug{B}" ; monitor debug_flag; evflag debug_flag_mon; sync debug_flag debug_flag_mon;


int bitflg; assign bitflg to "{P}{H}bitFlag{B}" ;
short bitsts; assign bitsts to "{P}{H}status{B}" ;
short bankctl; assign bankctl to "{P}{H}bank{B}" ; monitor bankctl; evflag bankctl_mon; sync bankctl bankctl_mon;

short filpos; assign filpos to "{P}{H}fPos{B}" ; monitor filpos; evflag filpos_mon; sync filpos filpos_mon;
string a00; assign a00 to "{P}{H}fPos{B}.ZRST" ;
string a01; assign a01 to "{P}{H}fPos{B}.ONST" ;
string a02; assign a02 to "{P}{H}fPos{B}.TWST" ;
string a03; assign a03 to "{P}{H}fPos{B}.THST" ;
string a04; assign a04 to "{P}{H}fPos{B}.FRST" ;
string a05; assign a05 to "{P}{H}fPos{B}.FVST" ;
string a06; assign a06 to "{P}{H}fPos{B}.SXST" ;
string a07; assign a07 to "{P}{H}fPos{B}.SVST" ;
string a08; assign a08 to "{P}{H}fPos{B}.EIST" ;
string a09; assign a09 to "{P}{H}fPos{B}.NIST" ;
string a10; assign a10 to "{P}{H}fPos{B}.TEST" ;
string a11; assign a11 to "{P}{H}fPos{B}.ELST" ;
string a12; assign a12 to "{P}{H}fPos{B}.TVST" ;
string a13; assign a13 to "{P}{H}fPos{B}.TTST" ;
string a14; assign a14 to "{P}{H}fPos{B}.FTST" ;
string a15; assign a15 to "{P}{H}fPos{B}.FFST" ;


double f1; assign f1 to "{P}{H}f1{B}" ; monitor f1; evflag f1_mon; sync f1 f1_mon;
double f2; assign f2 to "{P}{H}f2{B}" ; monitor f2; evflag f2_mon; sync f2 f2_mon;
double f3; assign f3 to "{P}{H}f3{B}" ; monitor f3; evflag f3_mon; sync f3 f3_mon;
double f4; assign f4 to "{P}{H}f4{B}" ; monitor f4; evflag f4_mon; sync f4 f4_mon;


short z1; assign z1 to "{P}{H}Z1{B}" ; monitor z1; evflag z1_mon; sync z1 z1_mon;
short z2; assign z2 to "{P}{H}Z2{B}" ; monitor z2; evflag z2_mon; sync z2 z2_mon;
short z3; assign z3 to "{P}{H}Z3{B}" ; monitor z3; evflag z3_mon; sync z3 z3_mon;
short z4; assign z4 to "{P}{H}Z4{B}" ; monitor z4; evflag z4_mon; sync z4 z4_mon;

string other1; assign other1 to "{P}{H}Other1{B}" ; monitor other1; evflag other1_mon; sync other1 other1_mon;
string other2; assign other2 to "{P}{H}Other2{B}" ; monitor other2; evflag other2_mon; sync other2 other2_mon;
string other3; assign other3 to "{P}{H}Other3{B}" ; monitor other3; evflag other3_mon; sync other3 other3_mon;
string other4; assign other4 to "{P}{H}Other4{B}" ; monitor other4; evflag other4_mon; sync other4 other4_mon;
string otherShow; assign otherShow to "{P}{H}OtherShow" ; monitor otherShow; evflag otherShow_mon; sync otherShow otherShow_mon;
float showEnergy[300];
assign showEnergy to "{P}{H}E";
float showTransmission[300];
assign showTransmission to "{P}{H}T";
int numShow; assign numShow to "{P}{H}E.NELM" ; monitor numShow;

short otherLegal1; assign otherLegal1 to "{P}{H}OtherLegal1{B}" ;
short otherLegal2; assign otherLegal2 to "{P}{H}OtherLegal2{B}" ;
short otherLegal3; assign otherLegal3 to "{P}{H}OtherLegal3{B}" ;
short otherLegal4; assign otherLegal4 to "{P}{H}OtherLegal4{B}" ;

char msg[256];
char* SNLtaskName;
short bits[16];
double xmit[16];
double energytimeout;

%{
static double TiAbsorptionLength(double);
static double GlassAbsorptionLength(double);
static double AlAbsorptionLength(double);
static int isLegalOther(char *s);
static double OtherAbsorptionLength(double keV, char *species);
static int fillShowArrays(char *species, int N, float *E, float *T);

static int numInArray(int,short*,short);
static void sortDecreasing(int,double*,short*,int);
static double thickZ(int,int,int,int,int,int,int,int,int,int,double,double,double,double);
static void RecalcFilters(double,short*,double*,int,int,int,int,int,int,double,double,double,double, char *, char *, char *, char *);
}%

ss pf4
{

    state init
    {
        when()
        {
            energytimeout = 0.0;
            SNLtaskName = macValueGet("name");

            pvGet(b1,SYNC); { displayBit1 = ( b1 ); pvPut(displayBit1,SYNC); };
            pvGet(b2,SYNC); { displayBit2 = ( b2 ); pvPut(displayBit2,SYNC); };
            pvGet(b3,SYNC); { displayBit3 = ( b3 ); pvPut(displayBit3,SYNC); };
            pvGet(b4,SYNC); { displayBit4 = ( b4 ); pvPut(displayBit4,SYNC); };
            pvGet(filpos,SYNC);
            pvGet(bankctl,SYNC);
            pvGet(monoenergy,SYNC); { displayEnergy = ( monoenergy ); pvPut(displayEnergy,SYNC); };
            pvGet(debug_flag,SYNC);

            pvGet(f1,SYNC);
            pvGet(f2,SYNC);
            pvGet(f3,SYNC);
            pvGet(f4,SYNC);

            pvGet(z1,SYNC);
            pvGet(z2,SYNC);
            pvGet(z3,SYNC);
            pvGet(z4,SYNC);

            { localenergy = ( monoenergy ); pvPut(localenergy,SYNC); };

            efClear(b1_mon);
            efClear(b2_mon);
            efClear(b3_mon);
            efClear(b4_mon);

            efClear(f1_mon);
            efClear(f2_mon);
            efClear(f3_mon);
            efClear(f4_mon);

            efClear(z1_mon);
            efClear(z2_mon);
            efClear(z3_mon);
            efClear(z4_mon);

            efClear(filpos_mon);
            efClear(bankctl_mon);
            efClear(selectenergy_mon);
            efClear(localenergy_mon);
            efClear(monoenergy_mon);
            efClear(debug_flag_mon);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 195, SNLtaskName, 2);; printf("%s\n", "init complete"); epicsThreadSleep(0.01); };

        } state idle

    }

    state filterBits
    {
        when()
        {
   { displayBit1 = ( b1 ); pvPut(displayBit1,SYNC); };
   { displayBit2 = ( b2 ); pvPut(displayBit2,SYNC); };
   { displayBit3 = ( b3 ); pvPut(displayBit3,SYNC); };
   { displayBit4 = ( b4 ); pvPut(displayBit4,SYNC); };

            { filpos = ( numInArray(16,bits,((b4<<3)|(b3<<2)|(b2<<1)|b1)) ); pvPut(filpos,SYNC); };
            { bitflg = ( (1 << filpos) ); pvPut(bitflg,SYNC); };
            { bitsts = ( bits[filpos] ); pvPut(bitsts,SYNC); };

            bankctl = (bankctl) ? 2 : 0;
            pvPut(bankctl,SYNC);

            efClear(filpos_mon);
        } state idle

    }

    state filterPos
    {
        when()
        {

            if (bits[filpos] & 0x1) {{ b1 = ( 1 ); pvPut(b1,SYNC); }; { displayBit1 = ( 1 ); pvPut(displayBit1,SYNC); };}
            if (bits[filpos] & 0x2) {{ b2 = ( 1 ); pvPut(b2,SYNC); }; { displayBit2 = ( 1 ); pvPut(displayBit2,SYNC); };}
            if (bits[filpos] & 0x4) {{ b3 = ( 1 ); pvPut(b3,SYNC); }; { displayBit3 = ( 1 ); pvPut(displayBit3,SYNC); };}
            if (bits[filpos] & 0x8) {{ b4 = ( 1 ); pvPut(b4,SYNC); }; { displayBit4 = ( 1 ); pvPut(displayBit4,SYNC); };}


            epicsThreadSleep((0.20));


            if (!(bits[filpos] & 0x1)) {{ b1 = ( 0 ); pvPut(b1,SYNC); }; { displayBit1 = ( 0 ); pvPut(displayBit1,SYNC); };}
            if (!(bits[filpos] & 0x2)) {{ b2 = ( 0 ); pvPut(b2,SYNC); }; { displayBit2 = ( 0 ); pvPut(displayBit2,SYNC); };}
            if (!(bits[filpos] & 0x4)) {{ b3 = ( 0 ); pvPut(b3,SYNC); }; { displayBit3 = ( 0 ); pvPut(displayBit3,SYNC); };}
            if (!(bits[filpos] & 0x8)) {{ b4 = ( 0 ); pvPut(b4,SYNC); }; { displayBit4 = ( 0 ); pvPut(displayBit4,SYNC); };}

            { bitflg = ( (1 << filpos) ); pvPut(bitflg,SYNC); };
            { bitsts = ( bits[filpos] ); pvPut(bitsts,SYNC); };

            efClear(b1_mon);
            efClear(b2_mon);
            efClear(b3_mon);
            efClear(b4_mon);
        } state recalcBank

    }

    state recalcBank
    {
        when( )
        {
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 256, SNLtaskName, 2);; printf("%s\n", "recalcBank"); epicsThreadSleep(0.01); };

            bankctl = (bankctl) ? 3 : 0;
            pvPut(bankctl,SYNC);
        } state idle
    }

    state bankControl
    {
        when( bankctl==0 )
        {
            sprintf(msg,"filter bank switched off (%d)",bankctl);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 268, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
        } state bankOff

        when( )
        {
            if( bankctl == 1 )
                sprintf(msg,"filter bank changed value to %d",bankctl);
            else if( bankctl == 2 )
            {
                if( z1==0 || z2==0 || z3==0 || z4==0 ) { filterAl = ( thickZ(0,bankctl,b1,b2,b3,b4,z1,z2,z3,z4,f1,f2,f3,f4) ); pvPut(filterAl,SYNC); };
                if( z1==1 || z2==1 || z3==1 || z4==1 ) { filterTi = ( thickZ(1,bankctl,b1,b2,b3,b4,z1,z2,z3,z4,f1,f2,f3,f4) ); pvPut(filterTi,SYNC); };
                if( z1==2 || z2==2 || z3==2 || z4==2 ) { filterGl = ( thickZ(2,bankctl,b1,b2,b3,b4,z1,z2,z3,z4,f1,f2,f3,f4) ); pvPut(filterGl,SYNC); };

                { trans = ( xmit[filpos] ); pvPut(trans,SYNC); };
                if( trans > 0.0 ) { invtrans = ( 1/trans ); pvPut(invtrans,SYNC); };

                { bitsts = ( bits[filpos] ); pvPut(bitsts,SYNC); };
                { bitflg = ( (1 << filpos) ); pvPut(bitflg,SYNC); };

                bankctl = (bankctl) ? 1 : 0;
                pvPut(bankctl,SYNC);

                sprintf(msg,"filter bank changed value to %d",bankctl);
            }
            else if( bankctl == 3 )
            {
                pvGet(localenergy,SYNC);
                efClear(localenergy_mon);
                RecalcFilters(localenergy,bits,xmit,debug_flag,bankctl,z1,z2,z3,z4,f1,f2,f3,f4,other1,other2,other3,other4);


                sprintf(a00,"%.3e",xmit[0]); pvPut(a00,SYNC);
                sprintf(a01,"%.3e",xmit[1]); pvPut(a01,SYNC);
                sprintf(a02,"%.3e",xmit[2]); pvPut(a02,SYNC);
                sprintf(a03,"%.3e",xmit[3]); pvPut(a03,SYNC);
                sprintf(a04,"%.3e",xmit[4]); pvPut(a04,SYNC);
                sprintf(a05,"%.3e",xmit[5]); pvPut(a05,SYNC);
                sprintf(a06,"%.3e",xmit[6]); pvPut(a06,SYNC);
                sprintf(a07,"%.3e",xmit[7]); pvPut(a07,SYNC);
                sprintf(a08,"%.3e",xmit[8]); pvPut(a08,SYNC);
                sprintf(a09,"%.3e",xmit[9]); pvPut(a09,SYNC);
                sprintf(a10,"%.3e",xmit[10]); pvPut(a10,SYNC);
                sprintf(a11,"%.3e",xmit[11]); pvPut(a11,SYNC);
                sprintf(a12,"%.3e",xmit[12]); pvPut(a12,SYNC);
                sprintf(a13,"%.3e",xmit[13]); pvPut(a13,SYNC);
                sprintf(a14,"%.3e",xmit[14]); pvPut(a14,SYNC);
                sprintf(a15,"%.3e",xmit[15]); pvPut(a15,SYNC);

                { bankctl = ( 2 ); pvPut(bankctl,SYNC); };
                sprintf(msg,"filter bank changed value to %d",bankctl);
            }
            else
                sprintf(msg,"invalid filter bank value of %d",bankctl);

            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 322, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
        } state idle
    }

    state bankOff
    {
        when( bankctl )
        {
            pvGet(selectenergy,SYNC);
            pvGet(localenergy,SYNC);
            pvGet(monoenergy,SYNC); { displayEnergy = ( monoenergy ); pvPut(displayEnergy,SYNC); };

            efClear(localenergy_mon);

            sprintf(msg,"filter bank switched on (%d)",bankctl);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 337, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
        } state recalcBank

        when( delay((0.10)) ) {} state bankOff
    }

    state idle
    {

        when( efTestAndClear(debug_flag_mon) )
        {
            sprintf(msg,"Debug level changed to %d",debug_flag);
            if (debug_flag >= 1) { printf("<%s,%d,%s,%d> ", "../pf4.st", 349, SNLtaskName, 1);; printf("%s\n", msg); epicsThreadSleep(0.01); };
        } state idle


        when( efTestAndClear(localenergy_mon) )
        {
            { selectenergy = ( 0 ); pvPut(selectenergy,SYNC); };
            epicsThreadSleep((0.01));
            efClear(selectenergy_mon);

            sprintf(msg,"local energy changed to %f",localenergy);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 360, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
        } state recalcBank


        when( efTestAndClear(selectenergy_mon) )
        {
            if( selectenergy )
            {
                { localenergy = ( monoenergy ); pvPut(localenergy,SYNC); };
                epicsThreadSleep((0.01));
                efClear(localenergy_mon);

                bankctl = (bankctl) ? 3 : 0;
                pvPut(bankctl,SYNC);
            }

            sprintf(msg,"using energy local/monochromator changed to %d",selectenergy);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 377, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
        } state idle


        when (efTestAndClear(monoenergy_mon)) {
            { displayEnergy = ( monoenergy ); pvPut(displayEnergy,SYNC); };
            if (selectenergy) {
    { localenergy = ( monoenergy ); pvPut(localenergy,SYNC); };
             epicsThreadSleep((0.01));
             efClear(localenergy_mon);
             energytimeout = (1.50);
             sprintf(msg,"monochromator energy changed to %f",monoenergy);
             if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 389, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
   }
  } state idle


        when( efTestAndClear(bankctl_mon) )
        {
            sprintf(msg,"filter bank changed to %d, going to state bankControl",bankctl);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 397, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
        } state bankControl


        when( efTestAndClear(f1_mon) || efTestAndClear(f2_mon) || efTestAndClear(f3_mon) ||
   efTestAndClear(f4_mon) )
        {
            sprintf(msg,"filters thickness changed to f1=%g, f2=%g, f3=%g, f3=%g",f1,f2,f3,f4);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 405, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };

            bankctl = (bankctl) ? 3 : 0;
            pvPut(bankctl,SYNC);
        } state idle


        when( efTestAndClear(z1_mon) || efTestAndClear(z2_mon) || efTestAndClear(z3_mon) ||
   efTestAndClear(z4_mon))
        {
            sprintf(msg,"filters material index changed to z1=%d, z2=%d, z3=%d, z4=%d",z1,z2,z3,z4);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 416, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };

            bankctl = (bankctl) ? 3 : 0;
            pvPut(bankctl,SYNC);
        } state idle


        when( efTestAndClear(other1_mon) || efTestAndClear(other2_mon) ||
   efTestAndClear(other3_mon) || efTestAndClear(other4_mon))
        {
            sprintf(msg,"filters material index changed to other1='%s', o2='%s', o3='%s', o4='%s'",
    other1,other2,other3,other4);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 428, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
   { otherLegal1 = ( isLegalOther(other1) ); pvPut(otherLegal1,SYNC); };
   { otherLegal2 = ( isLegalOther(other2) ); pvPut(otherLegal2,SYNC); };
   { otherLegal3 = ( isLegalOther(other3) ); pvPut(otherLegal3,SYNC); };
   { otherLegal4 = ( isLegalOther(other4) ); pvPut(otherLegal4,SYNC); };
            bankctl = (bankctl) ? 3 : 0;
            pvPut(bankctl,SYNC);
        } state idle


        when( efTestAndClear(b4_mon) || efTestAndClear(b3_mon) || efTestAndClear(b2_mon) ||
   efTestAndClear(b1_mon) )
        {
            sprintf(msg,"filter bits changed to (%1.1d%1.1d%1.1d%1.1d), going to state filterBits",
    b4,b3,b2,b1);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 443, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
        } state filterBits


        when( efTestAndClear(filpos_mon) && bankctl )
        {
            sprintf(msg,"filter position changed to %d, going to state filterPos",filpos);
            if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 450, SNLtaskName, 2);; printf("%s\n", msg); epicsThreadSleep(0.01); };
        } state filterPos

        when( delay((0.10)) )
        {
            if( energytimeout > 0.0 && (energytimeout = energytimeout - (0.10)) <= 0.0 )
            {
                bankctl = (bankctl) ? 3 : 0;
                pvPut(bankctl,SYNC);

                if (debug_flag >= 2) { printf("<%s,%d,%s,%d> ", "../pf4.st", 460, SNLtaskName, 2);; printf("%s\n", "energy timeout expired, force recalculation"); epicsThreadSleep(0.01); };
            }

        } state idle

  when (efTestAndClear(otherShow_mon)) {
   if (fillShowArrays(otherShow, numShow, showEnergy, showTransmission) == 0) {
    pvPut(showEnergy);
    pvPut(showTransmission);
   }
  } state idle
    }

}






%{



double AlAbsorptionLength(double keV)
{
    double Wcoef0[]={1.90195,-0.00120447,4.3745e-7,8.68635e-11,3.40793e-15,-1.05816e-19,5.83389e-25};
    double Wcoef1[]={-1625.33,0.328256,-2.68391e-5,1.26554e-9,-2.41557e-14,2.12864e-19,-7.28743e-25};
    double kink = 26797.5;
    double* pointer;
    double sum,power;
    double eV;
    int i;

    eV = keV * 1000;
    if (eV>60000.) eV = 60000.;
    pointer = (eV<kink) ? Wcoef0 : Wcoef1;
    sum = 0.;
    power=1.;
    for( i=0; i<7; i++ )
    {
        sum += pointer[i] * power;
        power *= eV;
    }
    return sum;
}



double TiAbsorptionLength(double keV)
{
    double eV;
    double mu;

    eV = keV * 1000.;
    if( eV < 1e3 ) mu = 0;
    else if( eV < 4966.4 )
    {
        double c0=0.00092284;
        double c1=2.5891e+08;
        double powA=-2.6651;
        mu = c0+c1*pow(eV,powA);
    }
    else
    {

        double offset = 5.63768167444831e-5;
        double amp = 24061652313.4169;
        double powB = -2.91380053083527;
        double intercept = -0.268162843203489;
        double slope = 3.74221014277593e-5;

        double ampExp = -1.05663835782997;
        double invTau = -0.000570785180739491;
        double extra = (eV < 6456) ? (intercept+slope*eV) : (ampExp*exp(invTau*eV));
        mu = (offset + amp*pow(eV,powB) + extra);
    }
    return( 1./mu );
}
# 553 "../pf4.st"
double GlassAbsorptionLength(double keV)
{
    double absLength;
    double c0,c1,c2;
    double c3,c4,c5,c6,c7;
    double keV2, keVn;
    keV2 = keV*keV;

    if( keV < 2 )
        absLength = 0;
    else if( keV < 2.472 )
    {
        c0 = 0.5059463974;
        c1 = -0.1259565387;
        c2 = 0.01763933889;
        absLength = c0 + c1*keV + c2*keV2;
    }
    else if( keV < 3.6084 )
    {
        c0 = 0.4570603245;
        c1 = -0.08869920063;
        c2 = 0.01032934773;
        absLength = c0 + c1*keV + c2*keV2;
    }
    else if( keV < 4.0385 )
    {
        c0 = 0.3708574258;
        c1 = -0.04453063888;
        c2 = 3.979930821e-3;
        absLength = c0 + c1*keV + c2*keV2;
    }
    else if( keV < 7.112 )
    {
        c0 = 0.2830642538;
        c1 = -0.0223186563;
        c2 = 1.412011413e-3;
        absLength = c0 + c1*keV + c2*keV2;
    }
    else
    {
        c0 = 0.2715022686;
        c1 = -0.02428526798;
        c2 = 2.984228845e-3;
        c3 = -2.003675391e-4;
        c4 = 7.983398893e-6;
        c5 = -1.869726202e-7;
        c6 = 2.378962632e-9;
        c7 = -1.270082060e-11;
        absLength = c0 + c1*keV;
        keVn = keV2; absLength += c2*keVn;
        keVn *= keV; absLength += c3*keVn;
        keVn *= keV; absLength += c4*keVn;
        keVn *= keV; absLength += c5*keVn;
        keVn *= keV; absLength += c6*keVn;
        keVn *= keV; absLength += c7*keVn;
    }
    absLength *= keV*keV*keV;
    return( absLength );
}

int isLegalOther(char *s) {
 int i;
 for (i=0; i<NUM_SPECIES; i++) {
  if (strcmp(filtermat[i].name, s) == 0) break;
 }
 if (i >= NUM_SPECIES) return(0);
 return(1);
}

double OtherAbsorptionLength(double keV, char *species) {
 int i, j;
 double mu, frac, absLen;

 for (i=0; i<NUM_SPECIES; i++) {
  if (strcmp(filtermat[i].name, species) == 0) break;
 }
 if (i >= NUM_SPECIES) {

  return(0.);
 }

 for (j=0; j<filtermat[i].numEntries; j++) {
  if (keV < filtermat[i].keV[j]) break;
 }
 if (j >= filtermat[i].numEntries) {

  return(0.);
 }

 frac = (keV - filtermat[i].keV[j]) / (filtermat[i].keV[j+1] - filtermat[i].keV[j]);
 mu = filtermat[i].mu[j] + frac * (filtermat[i].mu[j+1] - filtermat[i].mu[j]);
 absLen = 1/(matdensity[i]*mu);
 absLen *= 1.e4;
 return(absLen);
}


void RecalcFilters(double keV,short* bits,double* xmit,int d,int b,int z1,
                    int z2,int z3,int z4,double f1,double f2,double f3,double f4,
     char *other1, char *other2, char *other3, char *other4)
{
    double absLenAl,absLenTi,absLenGlass;
    double xAl,xTi,xGlass;
 double xOther1, xOther2, xOther3, xOther4;
    int i;
 double absLenOther1=0, absLenOther2=0, absLenOther3=0, absLenOther4=0;

    if (d >= 10) printf("\nRecalcFilters: keV=%g\n",keV);
    absLenAl = AlAbsorptionLength(keV);
    absLenTi = TiAbsorptionLength(keV);
    absLenGlass = GlassAbsorptionLength(keV);
 if (z1==3) absLenOther1 = OtherAbsorptionLength(keV, other1);
 if (z2==3) absLenOther2 = OtherAbsorptionLength(keV, other2);
 if (z3==3) absLenOther3 = OtherAbsorptionLength(keV, other3);
 if (z4==3) absLenOther4 = OtherAbsorptionLength(keV, other4);

    for (i=0;i<16;i++)
    {
        if (b)
        {
            xAl = (z1==0 && i&1) ? f1 : 0;
            xAl += (z2==0 && i&2) ? f2 : 0;
            xAl += (z3==0 && i&4) ? f3 : 0;
            xAl += (z4==0 && i&8) ? f4 : 0;
            xTi = (z1==1 && i&1) ? f1 : 0;
            xTi += (z2==1 && i&2) ? f2 : 0;
            xTi += (z3==1 && i&4) ? f3 : 0;
            xTi += (z4==1 && i&8) ? f4 : 0;
            xGlass = (z1==2 && i&1) ? f1 : 0;
            xGlass += (z2==2 && i&2) ? f2 : 0;
            xGlass += (z3==2 && i&4) ? f3 : 0;
            xGlass += (z4==2 && i&8) ? f4 : 0;
   xOther1 = (z1==3 && i&1) ? f1 : 0;
   xOther2 = (z2==3 && i&2) ? f2 : 0;
   xOther3 = (z3==3 && i&4) ? f3 : 0;
   xOther4 = (z4==3 && i&8) ? f4 : 0;
           if (d >= 10)
            {
                printf("       in RecalcFilters %3d, Aluminum = %g,   Titanium = %g,   Glass = %g\n",i,xAl,xTi,xGlass);
            }
            xmit[i] = exp(-xAl*1000./absLenAl);
            xmit[i] *= exp(-xTi*1000./absLenTi);
            xmit[i] *= exp(-xGlass*1000./absLenGlass);
   if (xOther1 > 0) xmit[i] *= exp(-xOther1*1000./absLenOther1);
   if (xOther2 > 0) xmit[i] *= exp(-xOther2*1000./absLenOther2);
   if (xOther3 > 0) xmit[i] *= exp(-xOther3*1000./absLenOther3);
   if (xOther4 > 0) xmit[i] *= exp(-xOther4*1000./absLenOther4);
        }
        else
            xmit[i] = 1.;
        bits[i] = i;
    }
    if (b) sortDecreasing(d,xmit,bits,16);
}


void sortDecreasing(int d,double* arr,short* bits,int n)
{
    int ii, jj;
    double a;
    short b;

    if (d >= 9)
    {
        printf("       before sorting, bits=%d",bits[0]);
        for (ii=1; ii<n; ii++)
        {
            printf(",%d", bits[ii]);
        }
        printf("\n");
        if (d >= 10)
        {
            printf("                   transmit=%g",arr[0]);
            for (ii=1; ii<n/3; ii++)
            {
                printf(", %g", arr[ii]);
            }
            printf("\n");
        }
    }

    for (jj=1;jj<n;jj++)
    {
        a = arr[jj];
        b = bits[jj];
        ii = jj-1;
        while(ii>=0 && arr[ii]<a)
        {
            arr[ii+1] = arr[ii];
            bits[ii+1] = bits[ii];
            ii--;
        }
        arr[ii+1] = a;
        bits[ii+1] = b;
    }

    if (d >= 8)
    {
        printf("       after sorting, bits=%d",bits[0]);
        for (ii=1; ii<n; ii++)
        {
            printf(",%d", bits[ii]);
        }
        printf("\n");
        if (d >= 10)
        {
            printf("                   transmit=%g",arr[0]);
            for (ii=1; ii<n/3; ii++)
            {
                printf(", %g", arr[ii]);
            }
            printf("\n");
        }
    }
}



double thickZ(int z,int b,int b1,int b2,int b3,int b4,int z1,int z2,int z3,
              int z4,double f1,double f2,double f3,double f4)
{
    double sum = 0.0;

    if( b )
    {
        sum += (b1 && (z1==z)) ? f1 : 0;
        sum += (b2 && (z2==z)) ? f2 : 0;
        sum += (b3 && (z3==z)) ? f3 : 0;
        sum += (b4 && (z4==z)) ? f4 : 0;
    }

    return sum;
}




int numInArray(int N,short arr[],short value)
{
    int i;

    for( i=0; i<N; i++ ) if( value==arr[i] ) return i;
    return 0;
}

static int fillShowArrays(char *species, int N, float *E, float *T) {
 int i, j, k;

 for (i=0; i<NUM_SPECIES; i++) {
  if (strcmp(filtermat[i].name, species) == 0) break;
 }
 if (i >= NUM_SPECIES) {
  return(1);
 }

 for (j=0; j<filtermat[i].numEntries; j++) {
  E[j] = filtermat[i].keV[j];
  T[j] = filtermat[i].mu[j];
 }
 k = j-1;
 for (; j<N; j++) {
  E[j] = filtermat[i].keV[k];
  T[j] = filtermat[i].mu[k];
 }
 return(0);
}

}%
