# 1 "../EnsembleTrajectoryScan.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../EnsembleTrajectoryScan.st"
program EnsembleTrajectoryScan("P=13IDC:,R=traj1,M1=M1,M2=M2,M3=M3,M4=M4,M5=M5,M6=M6,M7=M7,M8=M8,PORT=serial1")
# 24 "../EnsembleTrajectoryScan.st"
%% #include <stdlib.h>
%% #include <string.h>
%% #include <ctype.h>
%% #include <stdio.h>
%% #include <math.h>
%% #include <epicsString.h>
%% #include <epicsStdio.h>
%% #include <asynOctetSyncIO.h>

# 1 "/home/vasu/synApps/support/seq-2-2-5/include/seq_release.h" 1
# 34 "../EnsembleTrajectoryScan.st" 2
# 42 "../EnsembleTrajectoryScan.st"
option +r;
# 58 "../EnsembleTrajectoryScan.st"
# 1 "../EnsembleTrajectoryScan.h" 1
# 42 "../EnsembleTrajectoryScan.h"
int debugLevel; assign debugLevel to "{P}{R}DebugLevel.VAL";
monitor debugLevel;
int numAxes; assign numAxes to "{P}{R}NumAxes.VAL";
monitor numAxes;
int nelements; assign nelements to "{P}{R}Nelements.VAL";
monitor nelements;
int npulses; assign npulses to "{P}{R}Npulses.VAL";
monitor npulses;
int startPulses; assign startPulses to "{P}{R}StartPulses.VAL";
monitor startPulses;
int endPulses; assign endPulses to "{P}{R}EndPulses.VAL";
monitor endPulses;
int nactual; assign nactual to "{P}{R}Nactual.VAL";
int moveMode; assign moveMode to "{P}{R}MoveMode.VAL";
monitor moveMode;
double time; assign time to "{P}{R}Time.VAL";
monitor time;
double timeScale; assign timeScale to "{P}{R}TimeScale.VAL";
monitor timeScale;
int timeMode; assign timeMode to "{P}{R}TimeMode.VAL";
monitor timeMode;
double accel; assign accel to "{P}{R}Accel.VAL";
monitor accel;
int build; assign build to "{P}{R}Build.VAL";
monitor build;
int buildState; assign buildState to "{P}{R}BuildState.VAL";
int buildStatus; assign buildStatus to "{P}{R}BuildStatus.VAL";
string buildMessage;assign buildMessage to "{P}{R}BuildMessage.VAL";
int simMode; assign simMode to "{P}{R}SimMode.VAL";
monitor simMode;
int execute; assign execute to "{P}{R}Execute.VAL";
monitor execute;
int execState; assign execState to "{P}{R}ExecState.VAL";
monitor execState;
int execStatus; assign execStatus to "{P}{R}ExecStatus.VAL";
string execMessage; assign execMessage to "{P}{R}ExecMessage.VAL";
int abort; assign abort to "{P}{R}Abort.VAL";
monitor abort;
int readback; assign readback to "{P}{R}Readback.VAL";
monitor readback;
int readState; assign readState to "{P}{R}ReadState.VAL";
int readStatus; assign readStatus to "{P}{R}ReadStatus.VAL";
string readMessage; assign readMessage to "{P}{R}ReadMessage.VAL";
double timeTrajectory[1000];
assign timeTrajectory to "{P}{R}TimeTraj.VAL";
monitor timeTrajectory;
string trajectoryFile; assign trajectoryFile to "{P}{R}TrajectoryFile.VAL";
monitor trajectoryFile;




double elapsedTime; assign elapsedTime to "{P}{R}ElapsedTime.VAL";


double realTimeTrajectory[1000];
assign realTimeTrajectory to "{P}{R}realTimeTrajectory.VAL";


double epicsMotorMres[8];
assign epicsMotorMres to {"","","","","","","",""};
monitor epicsMotorMres;


int epicsMotorCard[8];
assign epicsMotorCard to {"","","","","","","",""};
monitor epicsMotorCard;


double epicsMotorHLM[8];
assign epicsMotorHLM to {"","","","","","","",""};
monitor epicsMotorHLM;
double epicsMotorLLM[8];
assign epicsMotorLLM to {"","","","","","","",""};
monitor epicsMotorLLM;

double motorStart[8];
assign motorStart to
        {"{P}{R}M1Start.VAL",
         "{P}{R}M2Start.VAL",
         "{P}{R}M3Start.VAL",
         "{P}{R}M4Start.VAL",
         "{P}{R}M5Start.VAL",
         "{P}{R}M6Start.VAL",
         "{P}{R}M7Start.VAL",
         "{P}{R}M8Start.VAL"};

int pulseDir;
assign pulseDir to "{P}{R}PulseDir";
monitor pulseDir;

double pulseLenUS;
assign pulseLenUS to "{P}{R}PulseLenUS";
monitor pulseLenUS;

int pulseSrc;
assign pulseSrc to "{P}{R}PulseSrc";
monitor pulseSrc;
# 149 "../EnsembleTrajectoryScan.h"
double pulsePositions[8000];
assign pulsePositions to "{P}{R}PulsePositions.VAL";





double newPulsePositions;
assign newPulsePositions to "{P}{R}NewPulsePositions.VAL";
monitor newPulsePositions;
evflag pulsePositionsMon; sync newPulsePositions pulsePositionsMon;


int numPulsePositions; assign numPulsePositions to "{P}{R}NumPulsePositions";
monitor numPulsePositions;





int pulseMode; assign pulseMode to "{P}{R}PulseMode.VAL";
monitor pulseMode;




int moveAxis[8];
assign moveAxis to
        {"{P}{R}M1Move.VAL",
         "{P}{R}M2Move.VAL",
         "{P}{R}M3Move.VAL",
         "{P}{R}M4Move.VAL",
         "{P}{R}M5Move.VAL",
         "{P}{R}M6Move.VAL",
         "{P}{R}M7Move.VAL",
         "{P}{R}M8Move.VAL"};
monitor moveAxis;

double motorTrajectory[8][1000];
assign motorTrajectory to
        {"{P}{R}M1Traj.VAL",
         "{P}{R}M2Traj.VAL",
         "{P}{R}M3Traj.VAL",
         "{P}{R}M4Traj.VAL",
         "{P}{R}M5Traj.VAL",
         "{P}{R}M6Traj.VAL",
         "{P}{R}M7Traj.VAL",
         "{P}{R}M8Traj.VAL"};
monitor motorTrajectory;

double motorReadbacks[8][8000];
assign motorReadbacks to
        {"{P}{R}M1Actual.VAL",
         "{P}{R}M2Actual.VAL",
         "{P}{R}M3Actual.VAL",
         "{P}{R}M4Actual.VAL",
         "{P}{R}M5Actual.VAL",
         "{P}{R}M6Actual.VAL",
         "{P}{R}M7Actual.VAL",
         "{P}{R}M8Actual.VAL"};

double motorError[8][8000];
assign motorError to
        {"{P}{R}M1Error.VAL",
         "{P}{R}M2Error.VAL",
         "{P}{R}M3Error.VAL",
         "{P}{R}M4Error.VAL",
         "{P}{R}M5Error.VAL",
         "{P}{R}M6Error.VAL",
         "{P}{R}M7Error.VAL",
         "{P}{R}M8Error.VAL"};

double motorCurrent[8];
assign motorCurrent to
        {"{P}{R}M1Current.VAL",
         "{P}{R}M2Current.VAL",
         "{P}{R}M3Current.VAL",
         "{P}{R}M4Current.VAL",
         "{P}{R}M5Current.VAL",
         "{P}{R}M6Current.VAL",
         "{P}{R}M7Current.VAL",
         "{P}{R}M8Current.VAL"};

double motorMDVS[8];
assign motorMDVS to
        {"{P}{R}M1MDVS.VAL",
         "{P}{R}M2MDVS.VAL",
         "{P}{R}M3MDVS.VAL",
         "{P}{R}M4MDVS.VAL",
         "{P}{R}M5MDVS.VAL",
         "{P}{R}M6MDVS.VAL",
         "{P}{R}M7MDVS.VAL",
         "{P}{R}M8MDVS.VAL"};
monitor motorMDVS;

double motorMDVA[8];
assign motorMDVA to
        {"{P}{R}M1MDVA.VAL",
         "{P}{R}M2MDVA.VAL",
         "{P}{R}M3MDVA.VAL",
         "{P}{R}M4MDVA.VAL",
         "{P}{R}M5MDVA.VAL",
         "{P}{R}M6MDVA.VAL",
         "{P}{R}M7MDVA.VAL",
         "{P}{R}M8MDVA.VAL"};

int motorMDVE[8];
assign motorMDVE to
        {"{P}{R}M1MDVE.VAL",
         "{P}{R}M2MDVE.VAL",
         "{P}{R}M3MDVE.VAL",
         "{P}{R}M4MDVE.VAL",
         "{P}{R}M5MDVE.VAL",
         "{P}{R}M6MDVE.VAL",
         "{P}{R}M7MDVE.VAL",
         "{P}{R}M8MDVE.VAL"};

double motorMVA[8];
assign motorMVA to
        {"{P}{R}M1MVA.VAL",
         "{P}{R}M2MVA.VAL",
         "{P}{R}M3MVA.VAL",
         "{P}{R}M4MVA.VAL",
         "{P}{R}M5MVA.VAL",
         "{P}{R}M6MVA.VAL",
         "{P}{R}M7MVA.VAL",
         "{P}{R}M8MVA.VAL"};

int motorMVE[8];
assign motorMVE to
        {"{P}{R}M1MVE.VAL",
         "{P}{R}M2MVE.VAL",
         "{P}{R}M3MVE.VAL",
         "{P}{R}M4MVE.VAL",
         "{P}{R}M5MVE.VAL",
         "{P}{R}M6MVE.VAL",
         "{P}{R}M7MVE.VAL",
         "{P}{R}M8MVE.VAL"};

double motorMAA[8];
assign motorMAA to
        {"{P}{R}M1MAA.VAL",
         "{P}{R}M2MAA.VAL",
         "{P}{R}M3MAA.VAL",
         "{P}{R}M4MAA.VAL",
         "{P}{R}M5MAA.VAL",
         "{P}{R}M6MAA.VAL",
         "{P}{R}M7MAA.VAL",
         "{P}{R}M8MAA.VAL"};

int motorMAE[8];
assign motorMAE to
        {"{P}{R}M1MAE.VAL",
         "{P}{R}M2MAE.VAL",
         "{P}{R}M3MAE.VAL",
         "{P}{R}M4MAE.VAL",
         "{P}{R}M5MAE.VAL",
         "{P}{R}M6MAE.VAL",
         "{P}{R}M7MAE.VAL",
         "{P}{R}M8MAE.VAL"};



double epicsMotorPos[8];
assign epicsMotorPos to {"","","","","","","",""};
monitor epicsMotorPos;

int epicsMotorDir[8];
assign epicsMotorDir to {"","","","","","","",""};
monitor epicsMotorDir;

double epicsMotorOff[8];
assign epicsMotorOff to {"","","","","","","",""};
monitor epicsMotorOff;

double epicsMotorDone[8];
assign epicsMotorDone to {"","","","","","","",""};
monitor epicsMotorDone;

double epicsMotorVELO[8];
assign epicsMotorVELO to {"","","","","","","",""};
monitor epicsMotorVELO;

double epicsMotorVMAX[8];
assign epicsMotorVMAX to {"","","","","","","",""};
monitor epicsMotorVMAX;

double epicsMotorVMIN[8];
assign epicsMotorVMIN to {"","","","","","","",""};
monitor epicsMotorVMIN;

double epicsMotorACCL[8];
assign epicsMotorACCL to {"","","","","","","",""};
monitor epicsMotorACCL;


evflag buildMon; sync build buildMon;
evflag executeMon; sync execute executeMon;
evflag execStateMon; sync execState execStateMon;
evflag abortMon; sync abort abortMon;
evflag readbackMon; sync readback readbackMon;
evflag nelementsMon; sync nelements nelementsMon;
evflag motorMDVSMon; sync motorMDVS motorMDVSMon;
# 59 "../EnsembleTrajectoryScan.st" 2
# 75 "../EnsembleTrajectoryScan.st"
char stringOut[100];
char stringIn[100];
char stringLast[100];
char abortCommand[100];
char *asynPort;
char *pasynUser;
int status;
int i;
int j;
int k;
int n;
int anyMoving;
int npoints;
double dtime;
double dpos;
double posActual;
double expectedTime;
double initialPos[8];
char macroBuf[100];
char motorName[100];
int initStatus;
int limitViolation;
int loadingTrajectory;



int motorCurrentIndex[8];
int epicsMotorDoneIndex[8];
int elapsedTimeIndex;





int abortState;

%%epicsTimeStamp startTime;
%%epicsTimeStamp currTime;
%%epicsTimeStamp lastPollTime;

%%epicsTimeStamp pvtTime;
%%epicsTimeStamp lastPvtTime;


%% static int writeOnly(SS_ID ssId, struct UserVar *pVar, char *command);
%% static int writeRead(SS_ID ssId, struct UserVar *pVar, char *command, char *reply);
%% static int getMotorPositions(SS_ID ssId, struct UserVar *pVar, double *pos);
%% static int getMotorMoving(SS_ID ssId, struct UserVar *pVar, int movingMask);
%% static int getEpicsMotorMoving(SS_ID ssId, struct UserVar *pVar);
%% static int waitEpicsMotors(SS_ID ssId, struct UserVar *pVar);
%% static int buildTrajectory(SS_ID ssId, struct UserVar *pVar, double *timeTrajectory,
%% double *motorTrajectory, int epicsMotorDir, int moveMode, int npoints, int npulses, double motorOffset,
%% double motorResolution, double *velocity);
%% static int loadTrajectory(SS_ID ssId, struct UserVar *pVar);
%% static int userToRaw(double user, double off, int dir, double res);
%% static double rawToUser(int raw, double off, int dir, double res);
%% static int sendReceiveCommand(SS_ID ssId, struct UserVar *pVar, char *cmd, char *callerReply, int checkProgram);
%% static double trajEval(SS_ID ssId, struct UserVar *pVar, double *motorReadbacks, int scopeDataIntervalMS, int nScopeDataPoints,
%% double *motorTrajectory, double *realTimeTrajectory, int npoints, double *motorError);
%% int writeDoubleAndCheck(SS_ID ssId, struct UserVar *pVar, int n, double d);
%% int writeIntAndCheck(SS_ID ssId, struct UserVar *pVar, int n, int ival);
double position[8][1000];
double velocity[8][1000];

double motorCurr[8];
double motorPosOffset[8];


int movingMask;
int numGlobalDoubles;
int numGlobalIntegers;


double vmax;
double amax;
double d, dlast;





int nScopeDataPoints;
int scopeDataIntervalMS;
# 170 "../EnsembleTrajectoryScan.st"
%%int encoder_runs_backwards=0;

int pulsePositionsLoaded;
int numPulsePositionsLoaded;

ss EnsembleTrajectoryScan {


 state init {
  when() {
   if (debugLevel) printf("EnsembleTrajectoryScan:init: entry\n");
   initStatus = 0;

   if (numAxes > 8) numAxes = 8;
   for (i=0; i<numAxes; i++) {
    sprintf(macroBuf, "M%d", i+1);

    sprintf(motorName, "%s%s.VAL", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorPos[i], motorName);
    pvMonitor(epicsMotorPos[i]);

    sprintf(motorName, "%s%s.DIR", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorDir[i], motorName);
    pvMonitor(epicsMotorDir[i]);

    sprintf(motorName, "%s%s.OFF", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorOff[i], motorName);
    pvMonitor(epicsMotorOff[i]);

    sprintf(motorName, "%s%s.DMOV", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorDone[i], motorName);
    pvMonitor(epicsMotorDone[i]);

    sprintf(motorName, "%s%s.MRES", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorMres[i], motorName);
    pvMonitor(epicsMotorMres[i]);

    sprintf(motorName, "%s%s.CARD", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorCard[i], motorName);
    pvMonitor(epicsMotorCard[i]);

    sprintf(motorName, "%s%s.HLM", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorHLM[i], motorName);
    pvMonitor(epicsMotorHLM[i]);

    sprintf(motorName, "%s%s.LLM", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorLLM[i], motorName);
    pvMonitor(epicsMotorLLM[i]);

    sprintf(motorName, "%s%s.VELO", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorVELO[i], motorName);
    pvMonitor(epicsMotorVELO[i]);

    sprintf(motorName, "%s%s.VMAX", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorVMAX[i], motorName);
    pvMonitor(epicsMotorVMAX[i]);

    sprintf(motorName, "%s%s.VBAS", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorVMIN[i], motorName);
    pvMonitor(epicsMotorVMIN[i]);

    sprintf(motorName, "%s%s.ACCL", macValueGet("P"), macValueGet(macroBuf));
    pvAssign(epicsMotorACCL[i], motorName);
    pvMonitor(epicsMotorACCL[i]);

   }
   asynPort = macValueGet("PORT");
   %%pVar->status = pasynOctetSyncIO->connect(pVar->asynPort, 0, (asynUser **)&pVar->pasynUser, NULL);
   if (status != 0) {
      printf("trajectoryScan error in pasynOctetSyncIO->connect\n");
      printf("   status=%d, port=%s\n", status, asynPort);
   }
   for (j=0; j<numAxes; j++) {
    motorCurrentIndex[j] = pvIndex(motorCurrent[j]);
    epicsMotorDoneIndex[j] = pvIndex(epicsMotorDone[j]);
    motorPosOffset[j] = 0.;
   }
   elapsedTimeIndex = pvIndex(elapsedTime);
   abortState = 0;


   efClear(buildMon);
   efClear(executeMon);
   efClear(abortMon);
   efClear(readbackMon);
   efClear(nelementsMon);
   efClear(motorMDVSMon);




   efClear(pulsePositionsMon);
   pvGet(pulsePositions);
   pulsePositionsLoaded = 0;
   numPulsePositionsLoaded = 0;

   if (initStatus == 0) initStatus = 1;
   loadingTrajectory = 0;


   %%pVar->status = writeRead(ssId, pVar, "getparm(125)", pVar->stringIn);
   if (stringIn[0] == '%') {
    numGlobalDoubles = atol(&stringIn[1]);
   } else {

    %%pVar->status = writeRead(ssId, pVar, "getparm(@0,125)", pVar->stringIn);
    if (stringIn[0] == '%') {
     numGlobalDoubles = atol(&stringIn[1]);
    } else {
     printf("Can't read number of global doubles.  Motor controller problem?\n");
     numGlobalDoubles = 0;
    }
   }


   %%pVar->status = writeRead(ssId, pVar, "getparm(124)", pVar->stringIn);
   if (stringIn[0] == '%') {
    numGlobalIntegers = atol(&stringIn[1]);
   } else {

    %%pVar->status = writeRead(ssId, pVar, "getparm(@0,124)", pVar->stringIn);
    if (stringIn[0] == '%') {
     numGlobalIntegers = atol(&stringIn[1]);
    } else {
     printf("Can't read number of global integers.  Motor controller problem?\n");
     numGlobalIntegers = 0;
    }
   }
   if (debugLevel) printf("EnsembleTrajectoryScan:init: done; going to 'monitor_inputs'\n");

  } state monitor_inputs
 }


 state monitor_inputs {
  entry {
   if (debugLevel) printf("EnsembleTrajectoryScan:monitor_inputs: entry\n");
  }
  when(efTestAndClear(buildMon) && (build==1) && (initStatus == 1)) {
  } state build

  when(efTestAndClear(executeMon) && (execute==1) && ((buildStatus == 1) || (buildStatus == 5))) {
  } state execute

  when(efTestAndClear(readbackMon) && (readback==1) ) {
   if (debugLevel>1) printf("readback command detected\n");
  } state readback

  when(efTestAndClear(nelementsMon) && (nelements>=1)) {



   if (nelements > (numGlobalDoubles/3 - 3)) {



    nelements = numGlobalDoubles/3 - 3;
    pvPut(nelements);
   }
   endPulses = nelements;
   pvPut(endPulses);
  } state monitor_inputs

  when (efTestAndClear(pulsePositionsMon)) {
   if (debugLevel) printf("EnsembleTrajectoryScan:monitor_inputs: pvGet(pulsePositions)\n");
   epicsThreadSleep(1.);
   pvGet(pulsePositions);
   if (debugLevel>1) {
    printf("EnsembleTrajectoryScan: new pulse positions detected\n");
    printf("...%lf, %lf...\n", pulsePositions[0], pulsePositions[1]);
   }
   pulsePositionsLoaded = 0;
   numPulsePositionsLoaded = 0;
  } state monitor_inputs
 }


 state build {
  when() {

   buildState = 1;
   pvPut(buildState);
   buildStatus=0;
   pvPut(buildStatus);
   epicsSnprintf(buildMessage, 40, "Building...");
   pvPut(buildMessage);

   buildStatus = 1;


   if (timeMode == 0) {
    dtime = time/(nelements-1);
    for (i=0; i<nelements; i++) timeTrajectory[i] = dtime;
    pvPut(timeTrajectory);
   } else {
    for (i=0, time=0.; i<nelements; i++) {
     time += timeTrajectory[i];
    }
    pvPut(time);
   }

   npoints = nelements;


   realTimeTrajectory[0] = 0.;
   for (i=1; i<npoints; i++) {
    realTimeTrajectory[i] = realTimeTrajectory[i-1] + timeTrajectory[i];
   }
   for (i=0; i<npoints; i++) realTimeTrajectory[i] *= timeScale;


   for (; i<1000; i++) realTimeTrajectory[i] = realTimeTrajectory[i-1];
   pvPut(realTimeTrajectory);


   n = sprintf(abortCommand, "ABORT");
   for (j=0; j<8; j++) {
    if (moveAxis[j]) {
     %%buildTrajectory(ssId, pVar, pVar->realTimeTrajectory, pVar->motorTrajectory[pVar->j],
     %% pVar->epicsMotorDir[pVar->j], pVar->moveMode, pVar->npoints, pVar->npulses,
     %% pVar->epicsMotorOff[pVar->j], pVar->epicsMotorMres[pVar->j], pVar->velocity[pVar->j]);
     n += sprintf(&abortCommand[n], " @%d", j);
    }
   }


   expectedTime = realTimeTrajectory[npoints-1];


   limitViolation = 0;
   for (j=0; j<numAxes && !limitViolation; j++) {
    if (moveAxis[j]) {
     vmax = epicsMotorVMAX[j];
     if (fabs(vmax) < .001) vmax = epicsMotorVELO[j];
     if (debugLevel>1) printf("vmax=%f\n", vmax);
     amax = vmax/epicsMotorACCL[j];
     motorMVA[j] = 0.;
     motorMAA[j] = 0.;
     for (k=0; k<npoints && !limitViolation; k++) {
      posActual = motorTrajectory[j][k];
      if (moveMode != 1) posActual += epicsMotorPos[j];
      limitViolation |= (posActual > epicsMotorHLM[j]) || (posActual < epicsMotorLLM[j]);
                  if (limitViolation) {
       epicsSnprintf(buildMessage, 40, "Limit: m%d at pt. %d (%f)", j+1, k+1, posActual);
      }
      if (velocity[j][k] > vmax) {
       limitViolation |= 1;
       epicsSnprintf(buildMessage, 40, "V limit: m%d at pt. %d (%f)", j+1, k+1,
        velocity[j][k]);
      }
      if (k > 1) {
       dtime = realTimeTrajectory[k]-realTimeTrajectory[k-1];
       d = (velocity[j][k] - velocity[j][k-1]) / dtime;
       if (fabs(d) > amax) {
        limitViolation |= 1;
        epicsSnprintf(buildMessage, 40, "A limit: m%d at pt. %d (%f)", j+1, k+1, d);
       }
       if ((dtime < .03) && (buildStatus != 5)) {
        buildStatus = 5;
        epicsSnprintf(buildMessage, 40, "!! deltaT(=%.3f) < .03 at pt. %d", dtime, k+1);
       }
      }
      motorMVA[j] = ((motorMVA[j]) > (fabs(velocity[j][k])) ? (motorMVA[j]) : (fabs(velocity[j][k])));

     }
     pvPut(motorMVA[j]);
     pvPut(motorMAA[j]);
    }
   }
   if (debugLevel>1) printf("limitViolation=%d\n", limitViolation);
   if (limitViolation) {
    buildStatus = 2;
   }




   buildState = 0;
   pvPut(buildState);
   pvPut(buildStatus);
   pvPut(buildMessage);


   build=0;
   pvPut(build);
   if (buildStatus == 1) {
    epicsSnprintf(buildMessage, 40, "Done");
    pvPut(buildMessage);
   }
  } state monitor_inputs
 }


 state execute {
  when () {
   execState = 1;
   pvPut(execState);
   abortState = 0;
   execStatus = 0;
   pvPut(execStatus);

   for (j=0; j<numAxes; j++) {
    for (i=0; i<8000; i++) {
     motorReadbacks[j][i] = 0.;
     motorError[j][i] = 0.;
    }
   }

   for (j=0; j<numAxes; j++) {
    initialPos[j] = epicsMotorPos[j];
    motorStart[j] = motorTrajectory[j][0] - (velocity[j][0] * epicsMotorACCL[j]) / 2;
    if (moveMode != 1) motorStart[j] += epicsMotorPos[j];
    pvPut(motorStart[j]);
   }

   for (j=0; j<numAxes; j++) {
    if (moveAxis[j]) {
     epicsMotorPos[j] = motorStart[j];
     pvPut(epicsMotorPos[j]);
     if (debugLevel > 0) printf("\nstate execute: moving motor %d to %f\n", j, epicsMotorPos[j]);
    }
   }
   %%waitEpicsMotors(ssId, pVar);


   %%getMotorPositions(ssId, pVar, pVar->motorCurr);
   for (j=0; j<numAxes; j++) {
    if (moveAxis[j]) {
     if (fabs(motorCurr[j] - motorStart[j]) > .01) {
      printf("state execute: motor %d didn't move to start\n", j);
      if (execStatus != 3) {
       execStatus = 3;
       %%pVar->status = writeRead(ssId, pVar, pVar->abortCommand, pVar->stringIn);
       abortState = 2;
       if (debugLevel) printf("abort: sent command '%s'\n", abortCommand);
      }
     }
    }
   }

   if (execStatus != 3) {

    %%getMotorPositions(ssId, pVar, pVar->motorStart);
    %%epicsTimeGetCurrent(&lastPollTime);


    elapsedTime = 0.;
    pvPut(elapsedTime);
    %%epicsTimeGetCurrent(&startTime);
    execState = 2;
    pvPut(execState);
    for (j=0, movingMask = 0; j<numAxes; j++) {
     if (moveAxis[j]) movingMask |= (1<<j);
    }



     for (i=0; i<10; i++) {
     %%pVar->status = loadTrajectory(ssId, pVar);
     if (status == -2) {
      printf("Trying trajectory again\n");
     } else {
      break;
     }
    }
   }
  } state wait_execute
 }


 state wait_execute {

  when (execStatus == 3) {



   execState = 0;
   pvPut(execState);


   execute = 0;
   pvPut(execute);
  } state monitor_inputs

  when ((execState==2) && delay(0.1)) {


   %%epicsTimeGetCurrent(&currTime);
   %%pVar->dtime = epicsTimeDiffInSeconds(&currTime, &lastPollTime);
   if (dtime > (1/5.)) {
    %%pVar->elapsedTime = epicsTimeDiffInSeconds(&currTime, &startTime);
    pvPut(elapsedTime);
    %%epicsTimeGetCurrent(&lastPollTime);
    %%getMotorPositions(ssId, pVar, pVar->motorCurrent);
    for (j=0; j<numAxes; j++) {
     if (moveAxis[j]) {
      pvPut(motorCurrent[j]);
     }
    }
    %%pVar->anyMoving = getMotorMoving(ssId, pVar, pVar->movingMask);
    if (anyMoving == 0) {
     execState = 3;
     execStatus = 1;
     strcpy(execMessage, " ");
    }

    if (elapsedTime > expectedTime*2.) {
     execState = 3;
     execStatus = 4;
     strcpy(execMessage, "Timeout");


     %%pVar->status = writeRead(ssId, pVar, pVar->abortCommand, pVar->stringIn);
     abortState = 2;
     if (debugLevel) printf("timeout: sent command '%s'\n", abortCommand);
     strcpy(stringOut, "PROGRAM STOP 1");
     %%pVar->status = writeRead(ssId, pVar, pVar->stringOut, pVar->stringIn);

     %%waitEpicsMotors(ssId, pVar);
     abortState = 3;
    }
   }

  } state wait_execute

  when (execState==3) {
   if (debugLevel>2) printf("flyback.\n");
   pvPut(elapsedTime);
   pvPut(execState);
   pvPut(execStatus);
   pvPut(execMessage);

   if (pulseMode != 3) {
    strcpy(stringOut, "PSOCONTROL @0 OFF");
    %%pVar->status = writeRead(ssId, pVar, pVar->stringOut, pVar->stringIn);
   }
   execState = 0;
   pvPut(execState);


   execute=0;
   pvPut(execute);
  } state monitor_inputs
 }


 state readback {
  entry {
   if (debugLevel) printf("readback: entry\n");
  }
  when() {

   readState = 1;
   pvPut(readState);
   readStatus=0;
   pvPut(readStatus);


   %%pVar->status = sendReceiveCommand(ssId, pVar, "SCOPETRIG STOP", pVar->stringIn, 1);
   strcpy(stringLast, "");
   if (debugLevel) printf("state readback: motorPosOffset[0]=%f\n", motorPosOffset[0]);
   for (i=0; i<nScopeDataPoints; i++) {
    if (execStatus == 3) break;
    sprintf(stringOut, "SCOPEDATA %d %d", 1, i);
    %%pVar->status = sendReceiveCommand(ssId, pVar, pVar->stringOut, pVar->stringIn, 0);
    sprintf(stringOut, "DGLOBAL(%d)", 1);
    %%pVar->status = writeRead(ssId, pVar, pVar->stringOut, pVar->stringIn);
    if (stringIn[0] == '%') {
     if (i==0) {

      for (j=0; j<10 ; j++) {
       strcpy(stringLast, stringIn);
       sprintf(stringOut, "SCOPEDATA %d %d", 1, i);
       %%pVar->status = sendReceiveCommand(ssId, pVar, pVar->stringOut, pVar->stringIn, 0);
       sprintf(stringOut, "DGLOBAL(%d)", 1);
       %%pVar->status = writeRead(ssId, pVar, pVar->stringOut, pVar->stringIn);
       if (strcmp(stringIn, stringLast) == 0) break;
       if (debugLevel) printf("**%d\n", i);
      }
      if (j==10) printf("abandoned read of point %d\n", i);
     } else {

      for (j=0; j<10 && (strcmp(stringIn, stringLast) == 0); j++) {
       if (debugLevel) printf("**%d\n", i);
       sprintf(stringOut, "SCOPEDATA %d %d", 1, i);
       %%pVar->status = sendReceiveCommand(ssId, pVar, pVar->stringOut, pVar->stringIn, 0);
       sprintf(stringOut, "DGLOBAL(%d)", 1);
       %%pVar->status = writeRead(ssId, pVar, pVar->stringOut, pVar->stringIn);
      }
      strcpy(stringLast, stringIn);
      if (j==10) printf("abandoned read of point %d\n", i);
     }
     k = atoi(&stringIn[1]);
     %%if (encoder_runs_backwards) pVar->k *= -1;
     motorReadbacks[0][i] = k * epicsMotorMres[0] + motorPosOffset[0];
     motorError[0][i] = motorReadbacks[0][i] - motorTrajectory[0][i];
    }
   }
   for (; i<8000; i++) {
    motorReadbacks[0][i] = 0;
    motorError[0][i] = 0;
   }
   %%pVar->d = trajEval(ssId, pVar, pVar->motorReadbacks[0], pVar->scopeDataIntervalMS, pVar->nScopeDataPoints,
   %%pVar->motorTrajectory[0], pVar->realTimeTrajectory, pVar->npoints, pVar->motorError[0]);
# 697 "../EnsembleTrajectoryScan.st"
            for (j=0; j<8; j++) {
                pvPut(motorReadbacks[j]);
                pvPut(motorError[j]);
            }

   readState = 0;
   pvPut(readState);

   readStatus = 1;
   pvPut(readStatus);
   strcpy(readMessage, " ");
   pvPut(readMessage);


   readback=0;
   pvPut(readback);
  } state monitor_inputs
 }
}





ss trajectoryAbort {
 state monitorAbort {
  when (efTest(abortMon) && (abort==1) && delay(0.1)) {
   if (debugLevel) printf("trajectoryAbort: loadingTrajectory=%d\n", loadingTrajectory);
   abortState = 1;
   if (!loadingTrajectory) {
    efClear(abortMon);
    %%pVar->status = writeRead(ssId, pVar, pVar->abortCommand, pVar->stringIn);
    if (debugLevel) printf("trajectoryAbort: sent command '%s'\n", abortCommand);
    abortState = 2;

    execStatus = 3;
    pvPut(execStatus);
    strcpy(execMessage, "Abort command sent");
    pvPut(execMessage);
    pvPut(elapsedTime);


    abort=0;
    pvPut(abort);
   }
  } state monitorAbort
 }
}



%{


static int writeOnly(SS_ID ssId, struct UserVar *pVar, char *command)
{
 asynStatus status=0;
 int debug_out=0;
 size_t nwrite;
 char buffer[100];


 strncpy(buffer, command, 100 -3);
 strcat(buffer, "\n");
 if (!(pVar->simMode)) {
  status = pasynOctetSyncIO->write((asynUser *)pVar->pasynUser, buffer,
          strlen(buffer), 1.0, &nwrite);
 }
 if (pVar->execState==2)
  debug_out = (pVar->debugLevel >= 7);
 else
  debug_out = (pVar->debugLevel >= 2);
 if (pVar->simMode || debug_out) printf("    writeOnly:command='%s'\n", command);
 return(status);
}





static int writeRead(SS_ID ssId, struct UserVar *pVar, char *command, char *reply)
{
 asynStatus status=0;
 char buffer[100];
 size_t nwrite, nread;
 int eomReason;

 strncpy(buffer, command, 100 -3);



 if (!(pVar->simMode)) {
  status = pasynOctetSyncIO->writeRead((asynUser *)pVar->pasynUser, buffer,
          strlen(buffer), reply, 100,
          30.0, &nwrite, &nread, &eomReason);
  if (status) printf("writeRead: pasynOctetSyncIO->writeRead returned %d\n", status);
 }
 if (pVar->simMode || (pVar->debugLevel >= 3)) {
  if (buffer[strlen(buffer)-1] == '\n') buffer[strlen(buffer)-1] = '\0';
  printf("    writeRead:command='%s', reply='%s'\n", buffer, reply);
 }
 return(status);
}




static int getMotorPositions(SS_ID ssId, struct UserVar *pVar, double *pos)
{
    int j, status;
    int dir, rawP;
 double rawF;
    char inputBuff[100], outputBuff[100];
 size_t nwrite, nread;
 int eomReason;

 for (j=0; j<pVar->numAxes; j++) {
  sprintf(outputBuff, "PFBKPROG(@%d)", j);
  status = pasynOctetSyncIO->writeRead((asynUser *)pVar->pasynUser, outputBuff,
          strlen(outputBuff), inputBuff, 100,
          30.0, &nwrite, &nread, &eomReason);
  if (status) printf("getMotorPositions: pasynOctetSyncIO->writeRead returned %d\n", status);
  if (inputBuff[0] != '%')
   rawF = 0;
  else
   rawF = atof(&inputBuff[1]);
  rawP = rawF / fabs(pVar->epicsMotorMres[j]);
        if (pVar->epicsMotorDir[j] == 0) dir=1; else dir=-1;
  pos[j] = rawToUser(rawP, pVar->epicsMotorOff[j], dir, pVar->epicsMotorMres[j]);
    }

 if (pVar->debugLevel > 2) {
  printf("pos[0]=%.2f\n", pos[0]);
 }

 return(0);
}




static int getMotorMoving(SS_ID ssId, struct UserVar *pVar, int movingMask)
{
    char inputBuff[100], outputBuff[100];
 size_t nwrite, nread;
 int eomReason;
 int move_active;
 int i, count, status;

 sprintf(outputBuff, "PLANESTATUS(0)");

 for (i=0, count=0; i<1; i++) {
  status = pasynOctetSyncIO->writeRead((asynUser *)pVar->pasynUser, outputBuff,
          strlen(outputBuff), inputBuff, 100,
          30.0, &nwrite, &nread, &eomReason);
  if (status) printf("getMotorMoving: pasynOctetSyncIO->writeRead returned %d\n", status);
  if (strlen(inputBuff) > 3) printf("getMotorMoving: PLANESTATUS(0) returned '%s'\n", inputBuff);
  if (pVar->debugLevel > 2) {
   printf("getMotorMoving: inputBuff='%s'\n", inputBuff);
  }
  move_active = atoi(&inputBuff[1]);
  if (move_active) {
   return(1);
  } else {
   count++;
   if (count>2) break;
  }
 }

 return(0);
}





static int getEpicsMotorMoving(SS_ID ssId, struct UserVar *pVar)
{
 int j;
 int result=0, mask=0x01;

 for (j=0; j<pVar->numAxes; j++) {
  seq_pvGet(ssId, pVar->epicsMotorDoneIndex[j], 0);
  if (pVar->epicsMotorDone[j] == 0) result |= mask;
  mask = mask << 1;
 }
 return(result);
}



static int waitEpicsMotors(SS_ID ssId, struct UserVar *pVar)
{
 int j;



 while (getEpicsMotorMoving(ssId, pVar)) {

  for (j=0; j<pVar->numAxes; j++) {
   pVar->motorCurrent[j] = pVar->epicsMotorPos[j];
   seq_pvPut(ssId, pVar->motorCurrentIndex[j], 0);
  }
  epicsThreadSleep((1/5.));
 }
 for (j=0; j<pVar->numAxes; j++) {
  pVar->motorCurrent[j] = pVar->epicsMotorPos[j];
  seq_pvPut(ssId, pVar->motorCurrentIndex[j], 0);
 }
 return(0);
}






static int buildTrajectory(SS_ID ssId, struct UserVar *pVar, double *realTimeTrajectory,
 double *motorTrajectory, int epicsMotorDir, int moveMode, int npoints, int npulses, double motorOffset,
 double motorResolution, double *velocity)
{
 double dp, dt, maxV=0;
 int i, status;
 char stringOut[100], reply[100];

 sprintf(stringOut, "GETPARM(%d)", 35);
 status = writeRead(ssId, pVar, stringOut, reply);

 if (reply[0] == '%') {
  maxV = atof(&reply[1]);
 } else {
  printf("buildTrajectory: Can't read velocityCommandThreshold parameter\n");
  return(-1);
 }



 for (i=0; i<npoints; i++) {
  if (i==0) {
   dp = motorTrajectory[1] - motorTrajectory[0];
   dt = realTimeTrajectory[1] - realTimeTrajectory[0];
   velocity[i] = dp/dt;
  } else {
   dp = motorTrajectory[i] - motorTrajectory[i-1];
   dt = realTimeTrajectory[i] - realTimeTrajectory[i-1];
   velocity[i] = 2*dp/dt - velocity[i-1];
  }
  if (pVar->debugLevel > 2) {
   printf("point %d: pos=%f, vel=%f, time=%f\n", i, motorTrajectory[i], velocity[i], realTimeTrajectory[i]);
  }
 }
# 969 "../EnsembleTrajectoryScan.st"
 for (i=0; i<npoints; i++) {
  if (fabs(velocity[i]) > maxV) {
   printf("velocity > limit %f at point %d: vel=%f\n", maxV, i, velocity[i]);
   return(-1);
  }
 }

 return(0);
}

static int userToRaw(double user, double off, int dir, double res) {
 return ((int)(((user-off)*dir/res)>0 ? ((user-off)*dir/res)+0.5 : ((user-off)*dir/res)-0.5));
}

static double rawToUser(int raw, double off, int dir, double res) {

 return (raw*res*dir+off);
}
# 999 "../EnsembleTrajectoryScan.st"
int sendReceiveCommand(SS_ID ssId, struct UserVar *pVar, char *cmd, char *callerReply, int checkProgram) {
 int i, i1, i2, i3, i4, cmdNum;
 double d1, d2, d3;
 char stringOut[100], reply[100];
 int status, saveDebug;

 if (pVar->debugLevel > 1) {
  printf("sendReceiveCommand: command='%s'\n", cmd);
 }
 if (checkProgram) {

  strcpy(stringOut, "TASKSTATE(1)");
  status = writeRead(ssId, pVar, stringOut, reply);
  status = atoi(&reply[1]);
  if (reply[0] == '!') {
   printf("sendReceiveCommand: 'TASKSTATE(1)' returned error.\n");
   return(-1);
  }
  switch (status) {
  case 0:
   if (strlen(reply) == 1) {
    printf("sendReceiveCommand: TASKSTATE(1)' returned '%s', which I'm ignoring\n", reply);
   } else {
    printf("sendReceiveCommand: TASKSTATE(1)' returned '%s'\n", reply);
    return(-1);
   }
   break;
  case 3:
   break;
  case 1:
  case 2:
  case 4:
  case 5:
   strcpy(stringOut, "PROGRAM RUN 1, \"doCommand.bcx\"");
   status = writeRead(ssId, pVar, stringOut, reply);
   epicsThreadSleep(.1);
   break;
  case 6:
   strcpy(stringOut, "PROGRAM STOP 1");
   status = writeRead(ssId, pVar, stringOut, reply);
   epicsThreadSleep(.1);
   strcpy(stringOut, "PROGRAM RUN 1, \"doCommand.bcx\"");
   status = writeRead(ssId, pVar, stringOut, reply);
   epicsThreadSleep(.1);
   break;
  default:

   break;
  }
 }


 saveDebug = pVar->debugLevel;
 pVar->debugLevel = ((0) > (pVar->debugLevel - 1) ? (0) : (pVar->debugLevel - 1));

 cmdNum = 0;
 if (strncmp(cmd, "VELOCITY ON", strlen("VELOCITY ON")) == 0) {
  cmdNum = 1;
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 1);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "DOTRAJECTORY", strlen("DOTRAJECTORY")) == 0) {
  cmdNum = 25;
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 25);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "VELOCITY OFF", strlen("VELOCITY OFF")) == 0) {
  cmdNum = 2;
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 2);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "HALT", strlen("HALT")) == 0) {
  cmdNum = 3;
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 3);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "STARTABORT", strlen("STARTABORT")) == 0) {
  cmdNum = 12;
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 12);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "START", strlen("START")) == 0) {
  cmdNum = 4;
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 4);
  if (callerReply != NULL) {
   status = writeRead(ssId, pVar, stringOut, reply);
  } else {
   status = writeOnly(ssId, pVar, stringOut);
  }
 } else if (strncmp(cmd, "PVT INIT TIME ABS", strlen("PVT INIT TIME ABS")) == 0) {
  cmdNum = 5;
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 5);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "PVT INIT TIME INC", strlen("PVT INIT TIME INC")) == 0) {
  cmdNum = 6;
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 6);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "PVT1", strlen("PVT1")) == 0) {
  cmdNum = 7;
  sscanf(cmd, "PVT1 %d %lf,%lf TIME %lf", &i1, &d1, &d2, &d3);
  status = writeIntAndCheck(ssId, pVar, 46, i1);
  status = writeDoubleAndCheck(ssId, pVar, 1, d1);
  status = writeDoubleAndCheck(ssId, pVar, 2, d2);
  status = writeDoubleAndCheck(ssId, pVar, 3, d3);
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 7);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "ABORT", strlen("ABORT")) == 0) {
  cmdNum = 11;
  i1 = i2 = i3 = i4 = -1;
  i = sscanf(cmd, "ABORT @%d @%d @%d @%d", &i1, &i2, &i3, &i4);
  status = writeIntAndCheck(ssId, pVar, 44, i);
  status = writeIntAndCheck(ssId, pVar, 46, i1);
  status = writeIntAndCheck(ssId, pVar, 47, i2);
  status = writeIntAndCheck(ssId, pVar, 48, i3);
  status = writeIntAndCheck(ssId, pVar, 49, i4);
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 11);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "SCOPEBUFFER", strlen("SCOPEBUFFER")) == 0) {
  cmdNum = 13;
  i1 = 0;
  i = sscanf(cmd, "SCOPEBUFFER %d", &i1);
  status = writeIntAndCheck(ssId, pVar, 46, i1);
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 13);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "SCOPEDATA", strlen("SCOPEDATA")) == 0) {
  cmdNum = 14;
  i1 = i2 = 0;
  i = sscanf(cmd, "SCOPEDATA %d %d", &i1, &i2);
  status = writeIntAndCheck(ssId, pVar, 46, i1);
  status = writeIntAndCheck(ssId, pVar, 47, i2);
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 14);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "SCOPESTATUS", strlen("SCOPESTATUS")) == 0) {
  cmdNum = 15;
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 15);
  status = writeRead(ssId, pVar, stringOut, reply);

 } else if (strncmp(cmd, "SCOPETRIG STOP", strlen("SCOPETRIG STOP")) == 0) {
  cmdNum = 16;
  status = writeIntAndCheck(ssId, pVar, 46, 1);
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 16);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "SCOPETRIGPERIOD", strlen("SCOPETRIGPERIOD")) == 0) {
  cmdNum = 17;

  i1 = 0;
  i = sscanf(cmd, "SCOPETRIGPERIOD %d", &i1);
  status = writeIntAndCheck(ssId, pVar, 46, i1);
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 17);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "SCOPETRIG", strlen("SCOPETRIG")) == 0) {
  cmdNum = 16;
  status = writeIntAndCheck(ssId, pVar, 46, 0);
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 16);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "LINEAR", strlen("LINEAR")) == 0) {
  cmdNum = 19;
  i1 = 0;
  d1 = d2 = 0;
  i = sscanf(cmd, "LINEAR @%d %lf F%lf", &i1, &d1, &d2);
  status = writeIntAndCheck(ssId, pVar, 46, i1);
  status = writeDoubleAndCheck(ssId, pVar, 1, d1);
  status = writeDoubleAndCheck(ssId, pVar, 2, d2);
  sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 19);
  status = writeRead(ssId, pVar, stringOut, reply);
 } else if (strncmp(cmd, "DATAACQ", strlen("DATAACQ")) == 0) {
  if (strncmp(cmd, "DATAACQ_TRIG", strlen("DATAACQ_TRIG")) == 0) {
   cmdNum = 20;
   i1 = i2 = 0;
   i = sscanf(cmd, "DATAACQ_TRIG @%d %d", &i1, &i2);
   status = writeIntAndCheck(ssId, pVar, 46, i1);
   status = writeIntAndCheck(ssId, pVar, 47, i2);
   sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 20);
   status = writeRead(ssId, pVar, stringOut, reply);
  } else if (strncmp(cmd, "DATAACQ_INP", strlen("DATAACQ_INP")) == 0) {
   cmdNum = 21;
   i1 = i2 = 0;
   i = sscanf(cmd, "DATAACQ_INP @%d %d", &i1, &i2);
   status = writeIntAndCheck(ssId, pVar, 46, i1);
   status = writeIntAndCheck(ssId, pVar, 47, i2);
   sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 21);
   status = writeRead(ssId, pVar, stringOut, reply);
  } else if (strncmp(cmd, "DATAACQ_ON", strlen("DATAACQ_ON")) == 0) {
   cmdNum = 22;
   i1 = i2 = 0;
   i = sscanf(cmd, "DATAACQ_ON @%d %d", &i1, &i2);
   status = writeIntAndCheck(ssId, pVar, 46, i1);
   status = writeIntAndCheck(ssId, pVar, 47, i2);
   sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 22);
   status = writeRead(ssId, pVar, stringOut, reply);
  } else if (strncmp(cmd, "DATAACQ_OFF", strlen("DATAACQ_OFF")) == 0) {
   cmdNum = 23;
   i1 = 0;
   i = sscanf(cmd, "DATAACQ_OFF @%d", &i1);
   status = writeIntAndCheck(ssId, pVar, 46, i1);
   sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 23);
   status = writeRead(ssId, pVar, stringOut, reply);
  } else if (strncmp(cmd, "DATAACQ_READ", strlen("DATAACQ_READ")) == 0) {
   cmdNum = 24;
   i1 = i2 = i3 = 0;
   i = sscanf(cmd, "DATAACQ_READ @%d %d %d", &i1, &i2, &i3);
   status = writeIntAndCheck(ssId, pVar, 46, i1);
   status = writeIntAndCheck(ssId, pVar, 47, i2);
   status = writeIntAndCheck(ssId, pVar, 48, i3);
   sprintf(stringOut, "IGLOBAL(%d) = %d", 45, 24);
   status = writeRead(ssId, pVar, stringOut, reply);
  } else {
   cmdNum = -1;
   printf("sendReceiveCommand: unexpected command: '%s'\n", cmd);
   return(-1);
  }
 }




 i = 0;
 if (cmdNum != 25) {
  sprintf(stringOut, "IGLOBAL(%d)", 45);
  for (i=0; i<300; i++) {
   status = writeRead(ssId, pVar, stringOut, reply);
   if (reply[0] == '%') {
    if (atoi(&reply[1]) == -cmdNum) break;
   }
   epicsThreadSleep(0.01);
  }
 }
 pVar->debugLevel = saveDebug;

 if (i>300 -1) {
  printf("sendReceiveCommand: timeout (%.2f s) executing '%s'; reply='%s'\n",
   300*0.01, cmd, reply);
  if (callerReply != NULL) {
   printf("... reply='%s'\n", reply);
  }

  status = writeIntAndCheck(ssId, pVar, 45, 0);
  return(-1);
 }
 return(0);
}

int writeDoubleAndCheck(SS_ID ssId, struct UserVar *pVar, int n, double d) {
 char stringOut[100], reply[100];
 double dCheck = -d;
 int i, status;

 for (i=0; i<10; i++) {
  sprintf(stringOut, "DGLOBAL(%d) = %f", n, d);
  status = writeRead(ssId, pVar, stringOut, reply);
  if (status) return(-1);
  sprintf(stringOut, "DGLOBAL(%d)", n);
  status = writeRead(ssId, pVar, stringOut, reply);
  if (status) return(-1);
  dCheck = atof(&reply[1]);
  if (fabs(d-dCheck) < .0001) break;
  printf("writeDoubleAndCheck: fix dglobal %d (%f != %f)\n", n, d, dCheck);
 }
 if (i==10) return(-1);
 return(0);
}

int writeIntAndCheck(SS_ID ssId, struct UserVar *pVar, int n, int ival) {
 char stringOut[100], reply[100];
 int iCheck = -ival;
 int i, status;

 for (i=0; i<10; i++) {
  sprintf(stringOut, "IGLOBAL(%d) = %d", n, ival);
  status = writeRead(ssId, pVar, stringOut, reply);
  if (status) return(-1);
  sprintf(stringOut, "IGLOBAL(%d)", n);
  status = writeRead(ssId, pVar, stringOut, reply);
  if (status) return(-1);
  iCheck = atol(&reply[1]);
  if (ival == iCheck) break;
  printf("writeIntAndCheck: fix iglobal %d (%d != %d)\n", n, ival, iCheck);
 }
 if (i==10) return(-1);
 return(0);
}
# 1284 "../EnsembleTrajectoryScan.st"
static int loadTrajectory(SS_ID ssId, struct UserVar *pVar) {
 int i, j, n, status;
 char stringOut[100], reply[100];
 double position, p, v, t, dp, dtime;
 int iGlobalIndex;
 int intPosition;
 double accelDist, accelTime, decelDist, decelTime, positionLast;
 double home_position_set=0.;
 double posfbkprog, posfbkcal;

 pVar->loadingTrajectory = 1;

 sprintf(stringOut, "getparm(@0,%d)", 1);
 status = writeRead(ssId, pVar, stringOut, reply);
 encoder_runs_backwards = atoi(&reply[1]);
 if (pVar->debugLevel > 2) printf("loadTrajectory: encoder_runs_backwards=%d\n", encoder_runs_backwards);

 sprintf(stringOut, "getparm(@0,%d)", 166);
 status = writeRead(ssId, pVar, stringOut, reply);
 home_position_set = atof(&reply[1]);
 if (pVar->debugLevel > 2) printf("loadTrajectory: home_position_set=%f\n", home_position_set);

 status = writeIntAndCheck(ssId, pVar, 42, 50);



 for (j=0; j<8; j++) {
  sprintf(stringOut, "pfbkprog(@%d)", j);
  status = writeRead(ssId, pVar, stringOut, reply);
  posfbkprog = atof(&reply[1]);
  sprintf(stringOut, "pfbkcal(@%d)", j);
  status = writeRead(ssId, pVar, stringOut, reply);
  posfbkcal = atof(&reply[1]);
  pVar->motorPosOffset[j] = posfbkprog - posfbkcal;
 }


 if (pVar->pulseMode != 3) {

  strcpy(stringOut, "PSOCONTROL @0 RESET");
  status = writeRead(ssId, pVar, stringOut, reply);
 }
# 1335 "../EnsembleTrajectoryScan.st"
 if ((pVar->pulseMode == 1) || (pVar->pulseMode == 2)) {

  int np;
  int maxArrayPulses = ((8192) > (pVar->numGlobalIntegers - 50) ? (pVar->numGlobalIntegers - 50) : (8192));



  if ((pVar->pulseMode == 1) &&
   (pVar->pulsePositionsLoaded != 1)) {
   if (pVar->debugLevel > 2) printf("loadTrajectory: load PULSE_MODE_ARRAY array\n");
   j = 0;

   positionLast = pVar->motorStart[j];
   iGlobalIndex = 50;
   if (pVar->numGlobalIntegers < (pVar->numPulsePositions + 50)) {
    printf("EnsembleTrajectoryScan: The Ensemble only has enough global integers for %d pulses\n",
     pVar->numGlobalIntegers - 50);
    pVar->numPulsePositions = pVar->numGlobalIntegers - 50;
   }
   if (pVar->numPulsePositions > 8192) {
    printf("EnsembleTrajectoryScan: The Ensemble can't load more than %d PSOARRAY pulses\n",
     8192);
    pVar->numPulsePositions = 8192;
   }
   for (i=0, np=0; i<pVar->numPulsePositions && np<maxArrayPulses; i++) {

    np++;
    position = pVar->pulsePositions[i];
    intPosition = (int)(((position - positionLast)/pVar->epicsMotorMres[j])>0 ? ((position - positionLast)/pVar->epicsMotorMres[j])+0.5 : ((position - positionLast)/pVar->epicsMotorMres[j])-0.5);
    status = writeIntAndCheck(ssId, pVar, iGlobalIndex++, abs(intPosition));
    positionLast += intPosition*pVar->epicsMotorMres[j];
   }
   pVar->pulsePositionsLoaded = 1;
   pVar->numPulsePositionsLoaded = np;
  } else if ((pVar->pulseMode == 2) &&
    (pVar->pulsePositionsLoaded != 2)) {

   if (pVar->debugLevel > 2) printf("loadTrajectory: load PULSE_MODE_TRAJPTS array\n");
   j = 0;
   positionLast = pVar->motorStart[j];
   iGlobalIndex = 50;
   if (pVar->numGlobalIntegers < (pVar->nelements + 50)) {
    printf("EnsembleTrajectoryScan: The Ensemble only has enough global integers for %d pulses\n",
     pVar->numGlobalIntegers - 50);
   }
   if (pVar->nelements > 8192) {
    printf("EnsembleTrajectoryScan: The Ensemble can't load more than %d PSOARRAY pulses\n",
     8192);
   }
   for (i=0, np=0; i<pVar->nelements && np<maxArrayPulses; i++) {

    if (i >= pVar->startPulses && i <= pVar->endPulses) {

     np++;
     position = pVar->motorTrajectory[j][i];
     intPosition = (int)(((position - positionLast)/pVar->epicsMotorMres[j])>0 ? ((position - positionLast)/pVar->epicsMotorMres[j])+0.5 : ((position - positionLast)/pVar->epicsMotorMres[j])-0.5);
     status = writeIntAndCheck(ssId, pVar, iGlobalIndex++, abs(intPosition));
     positionLast += intPosition*pVar->epicsMotorMres[j];
    }
   }
   pVar->pulsePositionsLoaded = 2;
   pVar->numPulsePositionsLoaded = np;
  }


  sprintf(stringOut, "PSOARRAY @0,%d,%d", 50, pVar->numPulsePositionsLoaded);
  status = writeRead(ssId, pVar, stringOut, reply);

  strcpy(stringOut, "PSODISTANCE @0 ARRAY");
  status = writeRead(ssId, pVar, stringOut, reply);
 }






 if (pVar->pulseMode != 3) {


  sprintf(stringOut, "PSOPULSE @0 TIME %f,%f", pVar->pulseLenUS*1.5, pVar->pulseLenUS);
  status = writeRead(ssId, pVar, stringOut, reply);
  strcpy(stringOut, "PSOOUTPUT @0 PULSE");
  status = writeRead(ssId, pVar, stringOut, reply);



  sprintf(stringOut, "PSOTRACK @0 INPUT %d", pVar->pulseSrc);
  status = writeRead(ssId, pVar, stringOut, reply);


  sprintf(stringOut, "PSOTRACK @0 DIRECTION %d", pVar->pulseDir);
  status = writeRead(ssId, pVar, stringOut, reply);

  if ((pVar->pulseMode == 1) || (pVar->pulseMode == 2)) {

   strcpy(stringOut, "PSODISTANCE @0 ARRAY");
   status = writeRead(ssId, pVar, stringOut, reply);
  } else if (pVar->pulseMode == 0) {

   dp = fabs(pVar->motorTrajectory[0][pVar->npoints-1] - pVar->motorTrajectory[0][0]) / pVar->npulses;
   sprintf(stringOut, "PSODISTANCE @0 FIXED %f UNITS", dp);
   status = writeRead(ssId, pVar, stringOut, reply);
  }
  strcpy(stringOut, "PSOCONTROL @0 ARM");
  status = writeRead(ssId, pVar, stringOut, reply);
 }



 getMotorPositions(ssId, pVar, pVar->motorCurrent);

 strcpy(stringOut, "TASKSTATE(1)");
 status = writeRead(ssId, pVar, stringOut, reply);
 status = atoi(&reply[1]);
 if ((reply[0] == '!') || ((status != 1) && (status != 3) && (status != 5))) {
  strcpy(stringOut, "PROGRAM STOP 1");
  status = writeRead(ssId, pVar, stringOut, reply);
  strcpy(stringOut, "TASKSTATE(1)");
  status = writeRead(ssId, pVar, stringOut, reply);
 }

 status = writeIntAndCheck(ssId, pVar, 45, 0);
 strcpy(stringOut, "PROGRAM RUN 1, \"doCommand.bcx\"");
 status = writeRead(ssId, pVar, stringOut, reply);
 epicsThreadSleep(.1);



 pVar->nScopeDataPoints = pVar->npoints * 2.2;
 if (pVar->nScopeDataPoints > 8000) pVar->nScopeDataPoints = 8000;
 pVar->scopeDataIntervalMS = (int)((1000 * (pVar->time*1.1)/pVar->nScopeDataPoints)>0 ? (1000 * (pVar->time*1.1)/pVar->nScopeDataPoints)+0.5 : (1000 * (pVar->time*1.1)/pVar->nScopeDataPoints)-0.5);
 if (pVar->scopeDataIntervalMS < 1) pVar->scopeDataIntervalMS = 1;
 sprintf(stringOut, "SCOPEBUFFER %d", pVar->nScopeDataPoints);
 status = sendReceiveCommand(ssId, pVar, stringOut, reply, 1);
 sprintf(stringOut, "SCOPETRIGPERIOD %d", pVar->scopeDataIntervalMS);
 status = sendReceiveCommand(ssId, pVar, stringOut, reply, 0);
# 1485 "../EnsembleTrajectoryScan.st"
 for (j=0; j<8; j++) {
  if (pVar->moveAxis[j]) break;
 }
 status = writeIntAndCheck(ssId, pVar, 46, j);


 accelTime = pVar->epicsMotorACCL[j];
 accelDist = (pVar->velocity[j][0] * pVar->epicsMotorACCL[j]) / 2;

 decelTime = pVar->epicsMotorACCL[j];
 decelDist = (pVar->velocity[j][pVar->npoints - 1] * pVar->epicsMotorACCL[j]) / 2;

 n = 0;
 status = 0;
 status += writeDoubleAndCheck(ssId, pVar, n++, pVar->motorTrajectory[j][0]);
 status += writeDoubleAndCheck(ssId, pVar, n++, pVar->velocity[j][0]);
 status += writeDoubleAndCheck(ssId, pVar, n++, accelTime);
 if (status) goto bad;

 for (i=1; i<pVar->npoints; i++) {
  p = pVar->motorTrajectory[j][i];
  v = pVar->velocity[j][i];
  t = accelTime + pVar->realTimeTrajectory[i];
  status += writeDoubleAndCheck(ssId, pVar, n++, p);
  status += writeDoubleAndCheck(ssId, pVar, n++, v);
  status += writeDoubleAndCheck(ssId, pVar, n++, t);
  if (status) goto bad;
 }


 p = 2*pVar->motorTrajectory[j][pVar->npoints-1] - pVar->motorTrajectory[j][pVar->npoints-2];
 v = pVar->velocity[j][pVar->npoints-1];
 t = accelTime + 2*pVar->realTimeTrajectory[pVar->npoints-1] - pVar->realTimeTrajectory[pVar->npoints-2];
 status += writeDoubleAndCheck(ssId, pVar, n++, p);
 status += writeDoubleAndCheck(ssId, pVar, n++, v);
 status += writeDoubleAndCheck(ssId, pVar, n++, t);
 if (status) goto bad;

 p = p + decelDist*.9;
 v = pVar->velocity[j][pVar->npoints-1]*.1;
 t = t + decelTime*.9;
 status += writeDoubleAndCheck(ssId, pVar, n++, p);
 status += writeDoubleAndCheck(ssId, pVar, n++, v);
 status += writeDoubleAndCheck(ssId, pVar, n++, t);
 if (status) goto bad;

 p = p + decelDist*.1;
 v = 0.;
 t = t + decelTime*.1;
 status += writeDoubleAndCheck(ssId, pVar, n++, p);
 status += writeDoubleAndCheck(ssId, pVar, n++, v);
 status += writeDoubleAndCheck(ssId, pVar, n++, t);
 if (status) goto bad;


 status = writeIntAndCheck(ssId, pVar, 47, n/3);


 status = sendReceiveCommand(ssId, pVar, "SCOPETRIG", reply, 0);


 epicsTimeGetCurrent(&startTime);
 sprintf(stringOut, "DOTRAJECTORY");
 status = sendReceiveCommand(ssId, pVar, stringOut, reply, 0);
# 1690 "../EnsembleTrajectoryScan.st"
 if (pVar->abortState != 0) goto abort;

 strcpy(stringOut, "TASKSTATE(1)");
 status = writeRead(ssId, pVar, stringOut, reply);
 if (pVar->debugLevel) printf("TASKSTATE = '%s', ", reply);
 strcpy(stringOut, "TASKERROR(1)");
 status = writeRead(ssId, pVar, stringOut, reply);
 if (pVar->debugLevel) printf("TASKERROR = '%s', ", reply);
 for (i=0; i<50; i++) {
  strcpy(stringOut, "PLANESTATUS(0)");
  status = writeRead(ssId, pVar, stringOut, reply);
  if (reply[1] == '3') break;
  epicsThreadSleep(.1);
 }
 if (i>=50) {
  printf("loadTrajectory: trajectory didn't start. (PLANESTATUS = '%s')\n", reply);
  strcpy(stringOut, "VELOCITY OFF");
  status = sendReceiveCommand(ssId, pVar, stringOut, reply, 1);


  status = writeRead(ssId, pVar, pVar->abortCommand, pVar->stringIn);
  return(-2);
 }
 if (pVar->debugLevel) printf("PLANESTATUS = '%s'\n", reply);
 pVar->loadingTrajectory = 0;
 if (pVar->debugLevel) printf("loadTrajectory: normal exit after %.1f s wait\n", i/10.);
 return(0);

bad:
 printf("loadTrajectory: error\n");

 strcpy(stringOut, "TASKSTATE(1)");
 status = writeRead(ssId, pVar, stringOut, reply);
 printf("TASKSTATE(1) returns '%s'\n", reply);
 strcpy(stringOut, "TASKERROR(1)");
 status = writeRead(ssId, pVar, stringOut, reply);
 printf("TASKERROR(1) returns '%s'\n", reply);
 strcpy(stringOut, "PLANESTATUS(0)");
 status = writeRead(ssId, pVar, stringOut, reply);
 printf("PLANESTATUS(0) returns '%s'\n", reply);
 strcpy(stringOut, "AXISSTATUS(@0)");
 status = writeRead(ssId, pVar, stringOut, reply);
 printf("AXISSTATUS(@0) returns '%s' (%x)\n", reply, atoi(&reply[1]));
 pVar->loadingTrajectory = 0;

 printf("loadTrajectory: aborting because of error\n");

abort:
 printf("loadTrajectory: aborted\n");
 strcpy(stringOut, "VELOCITY OFF");
 status = sendReceiveCommand(ssId, pVar, stringOut, reply, 1);
 strcpy(stringOut, "STARTABORT");
 status = sendReceiveCommand(ssId, pVar, stringOut, reply, 1);
 status = writeRead(ssId, pVar, pVar->abortCommand, pVar->stringIn);
 pVar->abortState = 2;
 pVar->loadingTrajectory = 0;
 if (pVar->pulseMode != 3) {
  strcpy(stringOut, "PSOCONTROL @0 OFF");
  status = writeRead(ssId, pVar, stringOut, reply);
 }
 return(-1);
}

double eval_fStart(double fStart, double *motorReadbacks, double scopeDataInterval, int nScopeDataPoints,
 double *motorTrajectory, double *realTimeTrajectory, int npoints);
int parabola(double *x, double *y, int npts, double *xFit);

static double trajEval(SS_ID ssId, struct UserVar *pVar, double *motorReadbacks, int scopeDataIntervalMS, int nScopeDataPoints,
 double *motorTrajectory, double *realTimeTrajectory, int npoints, double *motorError) {

 int i, rStart, lower, iThis;
 double fStart, fThis, frac, interp, scopeDataInterval = scopeDataIntervalMS*.001;
 double p;


 double fTry, x[10], y[10];
 int nTry;


 lower = motorReadbacks[0] < motorTrajectory[0];
 for (rStart=0; rStart < nScopeDataPoints/2; rStart++) {
  if (pVar->debugLevel>5) printf("trajEval: motorReadbacks[rStart]=%f, motorTrajectory[0]=%f\n", motorReadbacks[rStart], motorTrajectory[0]);
  if ((motorReadbacks[rStart] > motorTrajectory[0]) == lower) break;
 }
 if (rStart>1 && fabs(motorReadbacks[rStart] - motorReadbacks[rStart-1]) > 1.e-3) {
  frac = (motorTrajectory[0] - motorReadbacks[rStart-1]) / (motorReadbacks[rStart] - motorReadbacks[rStart-1]);
 } else {
  frac = 0.;
 }
 fStart = 0.;
 frac = 0.;
 if (rStart>0) {
  fStart = (rStart-1) + frac;
 }
 if (pVar->debugLevel>5) printf("trajEval: rStart=%d, frac=%f, fStart=%f\n", rStart, frac, fStart);


 fTry = ((0) > (fStart-2) ? (0) : (fStart-2));
 nTry = 5;
 for (i=0; i<nTry; i++, fTry += 1) {
  x[i] = fTry;
  y[i] = eval_fStart(fTry, motorReadbacks, scopeDataInterval, nScopeDataPoints, motorTrajectory, realTimeTrajectory, npoints);
 }
 i = parabola(x, y, nTry, &fTry);
 if (i==0) fStart = fTry;
 if (pVar->debugLevel>5) printf("trajEval: fStart=%f\n", fStart);


 for (i=0; i<npoints; i++) {
  fThis = fStart + (realTimeTrajectory[i] - realTimeTrajectory[0])/scopeDataInterval;
  iThis = floor(fThis);
  if (iThis+1 < nScopeDataPoints) {
   if (pVar->debugLevel>5) printf("trajEval: iThis=%d, motorReadbacks[iThis]=%f\n", iThis, motorReadbacks[iThis]);
   p = fThis-iThis;
   if ((iThis > 0) && (iThis+2 < nScopeDataPoints)) {

    interp = (-p*(p-1)*(p-2)/6)*motorReadbacks[iThis-1] +
      ((p*p-1)*(p-2)/2)*motorReadbacks[iThis] +
      (-p*(p+1)*(p-2)/2)*motorReadbacks[iThis+1] +
      (p*(p*p-1)/6)*motorReadbacks[iThis+2];
   } else if ((iThis > 0) && (iThis+1 < nScopeDataPoints)) {

    interp = (p*(p-1)/2)*motorReadbacks[iThis-1] + (1-p*p)*motorReadbacks[iThis] + (p*(p+1)/2)*motorReadbacks[iThis+1];
   } else {

    interp = motorReadbacks[iThis] + (motorReadbacks[iThis+1] - motorReadbacks[iThis])*p;
   }
   if (pVar->debugLevel>5) printf("trajEval: fThis=%f, interp=%f, motorTrajectory[%d]=%f, \n", fThis, interp, i, motorTrajectory[i]);
   motorReadbacks[i] = interp;
   motorError[i] = interp - motorTrajectory[i];
  } else {
   motorReadbacks[i] = 0;
   motorError[i] = 0;
  }
 }
 for(; i<nScopeDataPoints; i++) {
  motorReadbacks[i] = 0;
  motorError[i] = 0;
 }
 return(0.);
}

double eval_fStart(double fStart, double *motorReadbacks, double scopeDataInterval, int nScopeDataPoints,
 double *motorTrajectory, double *realTimeTrajectory, int npoints) {

 double fThis, p, interp, chisq = 0;
 int i, iThis, numChi = 0;


 for (i=0; i<npoints; i++) {
  fThis = fStart + (realTimeTrajectory[i] - realTimeTrajectory[0])/scopeDataInterval;
  iThis = floor(fThis);
  if (iThis+1 < nScopeDataPoints) {

   p = fThis-iThis;
   if ((iThis > 0) && (iThis+2 < nScopeDataPoints)) {

    interp = (-p*(p-1)*(p-2)/6)*motorReadbacks[iThis-1] +
      ((p*p-1)*(p-2)/2)*motorReadbacks[iThis] +
      (-p*(p+1)*(p-2)/2)*motorReadbacks[iThis+1] +
      (p*(p*p-1)/6)*motorReadbacks[iThis+2];
   } else if ((iThis > 0) && (iThis+1 < nScopeDataPoints)) {

    interp = (p*(p-1)/2)*motorReadbacks[iThis-1] + (1-p*p)*motorReadbacks[iThis] + (p*(p+1)/2)*motorReadbacks[iThis+1];
   } else {

    interp = motorReadbacks[iThis] + (motorReadbacks[iThis+1] - motorReadbacks[iThis])*p;
   }

   chisq += (interp - motorTrajectory[i]) * (interp - motorTrajectory[i]);
   numChi++;
  }
 }
 return(chisq/numChi);
}



int parabola(double *x, double *y, int npts, double *xFit) {

 double xf, yf;
 double xx, yy, xi, xi2, xi3, xi4, yi, yixi, yixi2;
 int i;
 double numer, denom;
 double xmin=1e10, xmax=-1e10;


 xi = yi = yixi = xi2 = yixi2 = xi3 = xi4 = 0.0;
 for (i=0; i<npts; i++) {
  xmin = ((xmin) > (x[i]) ? (x[i]) : (xmin));
  xmax = ((xmax) > (x[i]) ? (xmax) : (x[i]));
  xi += (xx = x[i]);
  yi += (yy = y[i]);
  yixi += yy * xx;
  xi2 += (xx *=x[i]);
  yixi2 += yy * xx;
  xi3 += (xx *= x[i]);
  xi4 += xx * x[i];
 }


 xi /= npts;
 xi2 /= npts;
 xi3 /= npts;
 xi4 /= npts;
 yi /= npts;
 yixi /= npts;
 yixi2 /= npts;


 numer = yi*(xi2*xi3 - xi*xi4) + yixi*(xi4 - xi2*xi2) + yixi2*(xi*xi2 - xi3);
 denom = 2*(yi*(xi2*xi2 - xi*xi3) + yixi*(xi3 - xi*xi2) + yixi2*(xi*xi - xi2));

 if (fabs(denom) < 1e-8) return(-1);
 xf = numer / denom;
 if ((xf < xmin) || (xf > xmax)) return(-1);

 numer = (xf*xf - 2*xf*xi + xi2) * (yixi2 - yi*xi2);
 denom = 2*xf*(xi*xi2 - xi3) - xi2*xi2 + xi4;
 yf = yi - numer/denom;
 if (fabs(denom) < 1e-8) return(-1);

 *xFit = xf;
 return(0);
}

}%
