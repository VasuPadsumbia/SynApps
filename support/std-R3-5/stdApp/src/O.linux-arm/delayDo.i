# 1 "../delayDo.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/home/vasu/gcc-arm-8.2-2019.01-x86_64-arm-linux-gnueabi/arm-linux-gnueabi/libc/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../delayDo.st"
program delayDo("name=delayDo,P=xxx:,R=delayDo1")
# 11 "../delayDo.st"
option +d;

option +r;



# 1 "../seqPVmacros.h" 1
# 18 "../delayDo.st" 2

char* SNLtaskName;
int resumeWaiting;

int debug_flag; assign debug_flag to "{P}{R}:debug.VAL" ; monitor debug_flag;
short enable; assign enable to "{P}{R}:enable.VAL" ; monitor enable; evflag enable_mon; sync enable enable_mon;
int standby; assign standby to "{P}{R}:standbyCalc" ; monitor standby; evflag standby_mon; sync standby standby_mon;
int active; assign active to "{P}{R}:activeCalc" ; monitor active; evflag active_mon; sync active active_mon;
double delayPeriod; assign delayPeriod to "{P}{R}:delay" ; monitor delayPeriod;
int doSeq; assign doSeq to "{P}{R}:doSeq.PROC" ;
string seqState; assign seqState to "{P}{R}:state" ;

ss delayDoMain
{

  state init
  {
    when ( pvConnectCount() == pvAssignCount() )
    {
      resumeWaiting = 0;
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 38, SNLtaskName, 3);; printf("%s\n", "init -> idle\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"idle"); pvPut(seqState,SYNC); };
    } state idle

  }

  state disable
  {
    when ( (efTestAndClear(enable_mon) && enable) )
    {

      efClear(active_mon);
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 50, SNLtaskName, 3);; printf("%s\n", "disable -> maybeStandby\n"); epicsThreadSleep(0.01); };


    } state maybeStandby
  }

  state maybeStandby
  {
    when ( standby )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 60, SNLtaskName, 3);; printf("%s\n", "maybeStandby -> standby\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"standby"); pvPut(seqState,SYNC); };
    } state standby

    when ( active )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 66, SNLtaskName, 3);; printf("%s\n", "maybeStandby -> active\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"active"); pvPut(seqState,SYNC); };
    } state active

    when ( ! standby )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 72, SNLtaskName, 3);; printf("%s\n", "maybeStandby -> idle\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"idle"); pvPut(seqState,SYNC); };
    } state idle

  }

  state idle
  {
    when ( efTestAndClear(enable_mon) && !enable )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 82, SNLtaskName, 3);; printf("%s\n", "idle -> disable\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"disable"); pvPut(seqState,SYNC); };
    } state disable

    when ( (efTestAndClear(standby_mon) && standby) )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 88, SNLtaskName, 3);; printf("%s\n", "idle -> standby\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"standby"); pvPut(seqState,SYNC); };
    } state standby

    when ( (efTestAndClear(active_mon) && active) )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 94, SNLtaskName, 3);; printf("%s\n", "idle -> active\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"active"); pvPut(seqState,SYNC); };
    } state active

  }

  state standby
  {
    when ( (efTestAndClear(enable_mon) && !enable) )
    {
      resumeWaiting = 0;
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 105, SNLtaskName, 3);; printf("%s\n", "standby -> disable\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"disable"); pvPut(seqState,SYNC); };
    } state disable

    when ( (efTestAndClear(standby_mon) && !standby) )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 111, SNLtaskName, 3);; printf("%s\n", "standby -> maybeWait\n"); epicsThreadSleep(0.01); };


    } state maybeWait

  }

  state maybeWait
  {

    when ( active )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 123, SNLtaskName, 3);; printf("%s\n", "maybeWait -> active\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"active"); pvPut(seqState,SYNC); };
    } state active




    when ( efTest(active_mon) || resumeWaiting )
    {
      efClear(active_mon);
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 133, SNLtaskName, 3);; printf("%s\n", "maybeWait -> waiting\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"waiting"); pvPut(seqState,SYNC); };
    } state waiting


    when ( ! efTest(active_mon) )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 140, SNLtaskName, 3);; printf("%s\n", "maybeWait -> idle\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"idle"); pvPut(seqState,SYNC); };
    } state idle

  }

  state active
  {
    when ( (efTestAndClear(enable_mon) && !enable) )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 150, SNLtaskName, 3);; printf("%s\n", "active -> disable\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"disable"); pvPut(seqState,SYNC); };
    } state disable

    when ( (efTestAndClear(standby_mon) && standby) )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 156, SNLtaskName, 3);; printf("%s\n", "active -> standby\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"standby"); pvPut(seqState,SYNC); };
    } state standby

    when ( (efTestAndClear(active_mon) && !active) )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 162, SNLtaskName, 3);; printf("%s\n", "active -> waiting\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"waiting"); pvPut(seqState,SYNC); };
    } state waiting

  }

  state waiting
  {
    when ( (efTestAndClear(enable_mon) && !enable) )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 172, SNLtaskName, 3);; printf("%s\n", "waiting -> disable\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"disable"); pvPut(seqState,SYNC); };
    } state disable

    when ( (efTestAndClear(standby_mon) && standby) )
    {
      resumeWaiting = 1;
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 179, SNLtaskName, 3);; printf("%s\n", "waiting -> standby\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"standby"); pvPut(seqState,SYNC); };
    } state standby

    when ( (efTestAndClear(active_mon) && active) )
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 185, SNLtaskName, 3);; printf("%s\n", "waiting -> active\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"active"); pvPut(seqState,SYNC); };
    } state active

    when ( delay( delayPeriod ) )
    {
      resumeWaiting = 0;
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 192, SNLtaskName, 3);; printf("%s\n", "waiting -> action\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"action"); pvPut(seqState,SYNC); };
    } state action

  }

  state action
  {

    when ()
    {
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 203, SNLtaskName, 3);; printf("%s\n", "Processing doSeq\n"); epicsThreadSleep(0.01); };
      { doSeq = ( 1 ); pvPut(doSeq,SYNC); };
      if (debug_flag >= 3) { printf("<%s,%d,%s,%d> ", "../delayDo.st", 205, SNLtaskName, 3);; printf("%s\n", "action -> idle\n"); epicsThreadSleep(0.01); };
      { strcpy(seqState,"idle"); pvPut(seqState,SYNC); };
    } state idle
  }

}
