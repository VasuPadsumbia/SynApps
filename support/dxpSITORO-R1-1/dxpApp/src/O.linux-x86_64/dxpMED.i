# 1 "../dxpMED.st"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 1 "<command-line>" 2
# 1 "../dxpMED.st"
program dxpMED("P=13GE2:med:,DXP=dxp,MCA=mca,N_DETECTORS=16,N_SCAS=16")
# 12 "../dxpMED.st"
option +r;



option -c;

%%#include <stdlib.h>
%%#include <errlog.h>
%%#include <string.h>
# 35 "../dxpMED.st"
int i;
int j;
int k;
int m;
int chan;
int det;
int nDetectors;
int nSCAs;
int allDone;
char temp[100];
double energy;
double slope;

char *prefix;
char *dxp;
char *mca;

double DetectionThreshold[100];
assign DetectionThreshold to {};
int CopyDetectionThreshold; assign CopyDetectionThreshold to "{P}CopyDetectionThreshold";
monitor CopyDetectionThreshold; evflag CopyDetectionThresholdMon; sync CopyDetectionThreshold CopyDetectionThresholdMon;

int MinPulsePairSeparation[100];
assign MinPulsePairSeparation to {};
int CopyMinPulsePairSeparation; assign CopyMinPulsePairSeparation to "{P}CopyMinPulsePairSeparation";
monitor CopyMinPulsePairSeparation; evflag CopyMinPulsePairSeparationMon; sync CopyMinPulsePairSeparation CopyMinPulsePairSeparationMon;

int DetectionFilter[100];
assign DetectionFilter to {};
int CopyDetectionFilter; assign CopyDetectionFilter to "{P}CopyDetectionFilter";
monitor CopyDetectionFilter; evflag CopyDetectionFilterMon; sync CopyDetectionFilter CopyDetectionFilterMon;

double ScaleFactor[100];
assign ScaleFactor to {};
int CopyScaleFactor; assign CopyScaleFactor to "{P}CopyScaleFactor";
monitor CopyScaleFactor; evflag CopyScaleFactorMon; sync CopyScaleFactor CopyScaleFactorMon;

double RisetimeOptimization[100];
assign RisetimeOptimization to {};
int CopyRisetimeOptimization; assign CopyRisetimeOptimization to "{P}CopyRisetimeOptimization";
monitor CopyRisetimeOptimization; evflag CopyRisetimeOptimizationMon; sync CopyRisetimeOptimization CopyRisetimeOptimizationMon;

int DetectorPolarity[100];
assign DetectorPolarity to {};
int CopyDetectorPolarity; assign CopyDetectorPolarity to "{P}CopyDetectorPolarity";
monitor CopyDetectorPolarity; evflag CopyDetectorPolarityMon; sync CopyDetectorPolarity CopyDetectorPolarityMon;

double DecayTime[100];
assign DecayTime to {};
int CopyDecayTime; assign CopyDecayTime to "{P}CopyDecayTime";
monitor CopyDecayTime; evflag CopyDecayTimeMon; sync CopyDecayTime CopyDecayTimeMon;

int ReadTrace[100];
assign ReadTrace to {};
int ReadTraces; assign ReadTraces to "{P}DoReadTraces";
monitor ReadTraces; evflag ReadTracesMon; sync ReadTraces ReadTracesMon;

int ReadMCA[100];
assign ReadMCA to {};
int ReadMCAs; assign ReadMCAs to "{P}DoReadAll";
monitor ReadMCAs; evflag ReadMCAsMon; sync ReadMCAs ReadMCAsMon;

int statusMCA[100];
assign statusMCA to {};
int StatusMCAs; assign StatusMCAs to "{P}DoStatusAll";
monitor StatusMCAs; evflag StatusMCAsMon; sync StatusMCAs StatusMCAsMon;

int Acquiring; assign Acquiring to "{P}Acquiring";
monitor Acquiring; evflag AcquiringMon; sync Acquiring AcquiringMon;

double mcaPresetReal[100];
assign mcaPresetReal to {};
double PresetReal; assign PresetReal to "{P}PresetReal";
monitor PresetReal; evflag PresetRealMon; sync PresetReal PresetRealMon;

double dxpPresetEvents[100];
assign dxpPresetEvents to {};
double PresetEvents; assign PresetEvents to "{P}PresetEvents";
monitor PresetEvents; evflag PresetEventsMon; sync PresetEvents PresetEventsMon;

double dxpPresetTriggers[100];
assign dxpPresetTriggers to {};
double PresetTriggers; assign PresetTriggers to "{P}PresetTriggers";
monitor PresetTriggers; evflag PresetTriggersMon; sync PresetTriggers PresetTriggersMon;

double dxpPresetMode[100];
assign dxpPresetMode to {};
double PresetMode; assign PresetMode to "{P}PresetMode";
monitor PresetMode; evflag PresetModeMon; sync PresetMode PresetModeMon;

double mcaDeadTime[100];
assign mcaDeadTime to {};
double DeadTime; assign DeadTime to "{P}DeadTime";
evflag DeadTimeMon; sync mcaDeadTime DeadTimeMon;

double mcaIDeadTime[100];
assign mcaIDeadTime to {};
double IDeadTime; assign IDeadTime to "{P}IDeadTime";
evflag IDeadTimeMon; sync mcaIDeadTime IDeadTimeMon;

int mcaNumChans[100];
assign mcaNumChans to {};

double mcaCalOffset[100];
assign mcaCalOffset to {};

double mcaCalSlope[100];
assign mcaCalSlope to {};

int mcaROILow[3200];
assign mcaROILow to {};

int mcaROIHigh[3200];
assign mcaROIHigh to {};

string mcaROIName[3200];
assign mcaROIName to {};

int dxpSCALow[3200];
assign dxpSCALow to {};

int dxpSCAHigh[3200];
assign dxpSCAHigh to {};

int CopyROIChannel; assign CopyROIChannel to "{P}CopyROIChannel";
monitor CopyROIChannel; evflag CopyROIChannelMon; sync CopyROIChannel CopyROIChannelMon;
int CopyROIEnergy; assign CopyROIEnergy to "{P}CopyROIEnergy";
monitor CopyROIEnergy; evflag CopyROIEnergyMon; sync CopyROIEnergy CopyROIEnergyMon;
int CopyROI_SCA; assign CopyROI_SCA to "{P}CopyROI_SCA";
monitor CopyROI_SCA; evflag CopyROI_SCAMon; sync CopyROI_SCA CopyROI_SCAMon;
int SNL_Connected; assign SNL_Connected to "{P}SNL_Connected";
int AsynDebug; assign AsynDebug to "{P}Asyn.TB1";
monitor AsynDebug;

int AcquireBusy; assign AcquireBusy to "{P}AcquireBusy";

ss dxp_control {
    state init {
        when() {


            prefix = macValueGet("P");
            dxp = macValueGet("DXP");
            mca = macValueGet("MCA");
            nDetectors = atoi(macValueGet("N_DETECTORS"));
            if ((nDetectors <= 0) || (nDetectors > 100)) {
                printf ("N_DETECTORS is illegal.\n");
                nDetectors = 0;
            }
            if (3200 != (100 * 32)) {
                printf ("N_DETECTORS, MAX_ROIS and TOTAL_ROIS are inconsistent.\n");
                nDetectors = 0;
            }
            if (3200 != (100 * 32)) {
                printf ("N_DETECTORS, MAX_SCAS and TOTAL_SCAS are inconsistent.\n");
                nDetectors = 0;
            }
            nSCAs = atoi(macValueGet("N_SCAS"));
            if ((nSCAs <= 0) || (nSCAs > 32)) {
                printf ("N_SCAS is illegal.\n");
                nSCAs = 0;
            }
             for (i=0; i<nDetectors; i++) {
                det = i+1;
                sprintf(temp, "%s%s%d:DetectionThreshold", prefix, dxp, det);
                pvAssign(DetectionThreshold[i], temp);

                sprintf(temp, "%s%s%d:MinPulsePairSeparation", prefix, dxp, det);
                pvAssign(MinPulsePairSeparation[i], temp);

                sprintf(temp, "%s%s%d:DetectionFilter", prefix, dxp, det);
                pvAssign(DetectionFilter[i], temp);

                sprintf(temp, "%s%s%d:ScaleFactor", prefix, dxp, det);
                pvAssign(ScaleFactor[i], temp);

                sprintf(temp, "%s%s%d:RisetimeOptimization", prefix, dxp, det);
                pvAssign(RisetimeOptimization[i], temp);

                sprintf(temp, "%s%s%d:DetectorPolarity", prefix, dxp, det);
                pvAssign(DetectorPolarity[i], temp);

                sprintf(temp, "%s%s%d:DecayTime", prefix, dxp, det);
                pvAssign(DecayTime[i], temp);

                sprintf(temp, "%s%s%d:TraceData.PROC", prefix, dxp, det);
                pvAssign(ReadTrace[i], temp);

                sprintf(temp, "%s%s%d:PresetMode", prefix, dxp, det);
                pvAssign(dxpPresetMode[i], temp);

                sprintf(temp, "%s%s%d:PresetEvents", prefix, dxp, det);
                pvAssign(dxpPresetEvents[i], temp);

                sprintf(temp, "%s%s%d:PresetTriggers", prefix, dxp, det);
                pvAssign(dxpPresetTriggers[i], temp);

                sprintf(temp, "%s%s%d.READ", prefix, mca, det);
                pvAssign(ReadMCA[i], temp);

                sprintf(temp, "%s%s%d.PROC", prefix, mca, det);
                pvAssign(statusMCA[i], temp);

                sprintf(temp, "%s%s%d.PRTM", prefix, mca, det);
                pvAssign(mcaPresetReal[i], temp);

                sprintf(temp, "%s%s%d.DTIM", prefix, mca, det);
                pvAssign(mcaDeadTime[i], temp);
                pvMonitor(mcaDeadTime[i]);

                sprintf(temp, "%s%s%d.IDTIM", prefix, mca, det);
                pvAssign(mcaIDeadTime[i], temp);
                pvMonitor(mcaIDeadTime[i]);

                sprintf(temp, "%s%s%d.CALO", prefix, mca, det);
                pvAssign(mcaCalOffset[i], temp);
                pvMonitor(mcaCalOffset[i]);

                sprintf(temp, "%s%s%d.CALS", prefix, mca, det);
                pvAssign(mcaCalSlope[i], temp);
                pvMonitor(mcaCalSlope[i]);

                sprintf(temp, "%s%s%d.NUSE", prefix, mca, det);
                pvAssign(mcaNumChans[i], temp);
                pvMonitor(mcaNumChans[i]);

                for (j=0; j<32; j++) {
                    k = i*32 + j;

                    sprintf(temp, "%s%s%d.R%dLO", prefix, mca, det, j);
                    pvAssign(mcaROILow[k], temp);

                    sprintf(temp, "%s%s%d.R%dHI", prefix, mca, det, j);
                    pvAssign(mcaROIHigh[k], temp);

                    sprintf(temp, "%s%s%d.R%dNM", prefix, mca, det, j);
                    pvAssign(mcaROIName[k], temp);
                }

                for (j=0; j<nSCAs; j++) {
                    k = i*32 + j;

                    sprintf(temp, "%s%s%d:SCA%dLow", prefix, dxp, det, j);
                    pvAssign(dxpSCALow[k], temp);

                    sprintf(temp, "%s%s%d:SCA%dHigh", prefix, dxp, det, j);
                    pvAssign(dxpSCAHigh[k], temp);
                }
           }
        } state waitConnected
    }
    state waitConnected {

        when (nDetectors <= 0) {
          printf (">>>>>>>>>>>>>> dxpMED is dead. <<<<<<<<<<<<<<\n");
        } state dead

        when (pvAssignCount () == pvConnectCount ()) {
          printf ("dxpMED: All channels connected.\n");
          SNL_Connected = 1;
          pvPut(SNL_Connected);
        } state monitor_changes

    }
    state dead {
      when (delay (3600.0)) {
      } state dead
    }

    state monitor_changes {

        when (pvAssignCount () != pvConnectCount ()) {
          printf ("dxpMED: Not all channels connected.\n");
        } state waitConnected

        when(efTestAndClear(CopyDetectionThresholdMon) && (CopyDetectionThreshold == 1)) {
            pvGet(DetectionThreshold[0]);
            for (i=0; i<nDetectors; i++) {
                DetectionThreshold[i] = DetectionThreshold[0];
                pvPut(DetectionThreshold[i]);
            }
            CopyDetectionThreshold = 0;
            pvPut(CopyDetectionThreshold);
        } state monitor_changes

        when(efTestAndClear(CopyMinPulsePairSeparationMon) && (CopyMinPulsePairSeparation == 1)) {
            pvGet(MinPulsePairSeparation[0]);
            for (i=0; i<nDetectors; i++) {
                MinPulsePairSeparation[i] = MinPulsePairSeparation[0];
                pvPut(MinPulsePairSeparation[i]);
            }
            CopyMinPulsePairSeparation = 0;
            pvPut(CopyMinPulsePairSeparation);
        } state monitor_changes

        when(efTestAndClear(CopyDetectionFilterMon) && (CopyDetectionFilter == 1)) {
            pvGet(DetectionFilter[0]);
            for (i=0; i<nDetectors; i++) {
                DetectionFilter[i] = DetectionFilter[0];
                pvPut(DetectionFilter[i]);
            }
            CopyDetectionFilter = 0;
            pvPut(CopyDetectionFilter);
        } state monitor_changes

        when(efTestAndClear(CopyScaleFactorMon) && (CopyScaleFactor == 1)) {
            pvGet(ScaleFactor[0]);
            for (i=0; i<nDetectors; i++) {
                ScaleFactor[i] = ScaleFactor[0];
                pvPut(ScaleFactor[i]);
            }
            CopyScaleFactor = 0;
            pvPut(CopyScaleFactor);
        } state monitor_changes

        when(efTestAndClear(CopyRisetimeOptimizationMon) && (CopyRisetimeOptimization == 1)) {
            pvGet(RisetimeOptimization[0]);
            for (i=0; i<nDetectors; i++) {
                RisetimeOptimization[i] = RisetimeOptimization[0];
                pvPut(RisetimeOptimization[i]);
            }
            CopyRisetimeOptimization = 0;
            pvPut(CopyRisetimeOptimization);
        } state monitor_changes

        when(efTestAndClear(CopyDetectorPolarityMon) && (CopyDetectorPolarity == 1)) {
            pvGet(DetectorPolarity[0]);
            for (i=0; i<nDetectors; i++) {
                DetectorPolarity[i] = DetectorPolarity[0];
                pvPut(DetectorPolarity[i]);
            }
            CopyDetectorPolarity = 0;
            pvPut(CopyDetectorPolarity);
        } state monitor_changes

        when(efTestAndClear(CopyDecayTimeMon) && (CopyDecayTime == 1)) {
            pvGet(DecayTime[0]);
            for (i=0; i<nDetectors; i++) {
                DecayTime[i] = DecayTime[0];
                pvPut(DecayTime[i]);
            }
            CopyDecayTime = 0;
            pvPut(CopyDecayTime);
        } state monitor_changes

        when(efTestAndClear(ReadTracesMon) && (ReadTraces == 1)) {
            for (i=0; i<nDetectors; i++) {
                ReadTrace[i] = 1;
                pvPut(ReadTrace[i]);
            }
            ReadTraces = 0;
            pvPut(ReadTraces);
        } state monitor_changes
        when(efTestAndClear(ReadMCAsMon) && (ReadMCAs == 1)) {
            if (AsynDebug) printf("dxpMED.st: Read MCA data\n");
            for (i=0; i<nDetectors; i++) {
                ReadMCA[i] = 1;
                pvPut(ReadMCA[i]);
            }
            ReadMCAs = 0;
            pvPut(ReadMCAs);
        } state monitor_changes

        when(efTestAndClear(StatusMCAsMon) && (StatusMCAs == 1)) {
            if (AsynDebug) printf("dxpMED.st: Read MCA status\n");
            for (i=0; i<nDetectors; i++) {
                statusMCA[i] = 1;
                pvPut(statusMCA[i]);
            }
            StatusMCAs = 0;
            pvPut(StatusMCAs);
        } state monitor_changes


        when(efTestAndClear(AcquiringMon)) {
            if (AsynDebug) printf("dxpMED.st: AcquiringMon, Acquiring=%d\n", Acquiring);

            if (Acquiring) {
                for (i=0; i<nDetectors; i++) {
                    statusMCA[i] = 1;

                }
            } else {

                for (i=0; i<nDetectors; i++) {
                    ReadMCA[i] = 1;
                    pvPut(ReadMCA[i], SYNC);
                }

                AcquireBusy = 0;
                pvPut(AcquireBusy);
            }
        } state monitor_changes

        when(efTestAndClear(PresetModeMon)) {
            for (i=0; i<nDetectors; i++) {
                dxpPresetMode[i] = PresetMode;
                pvPut(dxpPresetMode[i]);
            }
        } state monitor_changes

        when(efTestAndClear(PresetRealMon)) {
            for (i=0; i<nDetectors; i++) {
                mcaPresetReal[i] = PresetReal;
                pvPut(mcaPresetReal[i]);
            }
        } state monitor_changes

        when(efTestAndClear(PresetEventsMon)) {
            for (i=0; i<nDetectors; i++) {
                dxpPresetEvents[i] = PresetEvents;
                pvPut(dxpPresetEvents[i]);
            }
        } state monitor_changes

        when(efTestAndClear(PresetTriggersMon)) {
            for (i=0; i<nDetectors; i++) {
                dxpPresetTriggers[i] = PresetTriggers;
                pvPut(dxpPresetTriggers[i]);
            }
        } state monitor_changes

        when(efTestAndClear(DeadTimeMon)) {
            DeadTime = 0.;
            for (i=0; i<nDetectors; i++) {
                DeadTime += mcaDeadTime[i];
            }
            DeadTime /= nDetectors;
            pvPut(DeadTime);
        } state monitor_changes

        when(efTestAndClear(IDeadTimeMon)) {
            IDeadTime = 0.;
            for (i=0; i<nDetectors; i++) {
                IDeadTime += mcaIDeadTime[i];
            }
            IDeadTime /= nDetectors;
            pvPut(IDeadTime);
        } state monitor_changes


        when(efTestAndClear(CopyROIChannelMon) && (CopyROIChannel == 1)) {
            for (i=1; i<nDetectors; i++) {
                for (j=0; j<32; j++) {
                    pvGet(mcaROILow[j]);
                    pvGet(mcaROIHigh[j]);
                    pvGet(mcaROIName[j]);
                    k = i*32 + j;
                    chan = mcaROILow[j];
                    if (chan < 0) chan = 0;
                    mcaROILow[k] = chan;
                    pvPut(mcaROILow[k]);
                    chan = mcaROIHigh[j];
                    if (chan < 0) chan = 0;
                    mcaROIHigh[k] = chan;
                    pvPut(mcaROIHigh[k]);
                    strcpy(mcaROIName[k], mcaROIName[j]);
                    pvPut(mcaROIName[k]);
                }
            }
            CopyROIChannel = 0;
            pvPut(CopyROIChannel);
        } state monitor_changes


        when(efTestAndClear(CopyROIEnergyMon) && (CopyROIEnergy == 1)) {
            for (i=1; i<nDetectors; i++) {
                for (j=0; j<32; j++) {
                    pvGet(mcaROILow[j]);
                    pvGet(mcaROIHigh[j]);
                    pvGet(mcaROIName[j]);
                    k = i*32 + j;
                    energy = mcaCalOffset[0] + mcaROILow[j] * mcaCalSlope[0];
                    slope = mcaCalSlope[i];
                    if (slope == 0.0) slope = 1;
                    chan = 0.5 + ((energy - mcaCalOffset[i]) / slope);
                    if (chan < 0) chan = 0;
                    if (chan > mcaNumChans[i]-1) chan = mcaNumChans[i]-1;
                    mcaROILow[k] = chan;
                    pvPut(mcaROILow[k]);
                    energy = mcaCalOffset[0] + mcaROIHigh[j] * mcaCalSlope[0];
                    chan = 0.5 + ((energy - mcaCalOffset[i]) / slope);
                    if (chan < 0) chan = 0;
                    if (chan > mcaNumChans[i]-1) chan = mcaNumChans[i]-1;
                    mcaROIHigh[k] = chan;
                    pvPut(mcaROIHigh[k]);
                    strcpy(mcaROIName[k], mcaROIName[j]);
                    pvPut(mcaROIName[k]);
                }
            }
            CopyROIEnergy = 0;
            pvPut(CopyROIEnergy);
        } state monitor_changes


        when(efTestAndClear(CopyROI_SCAMon) && (CopyROI_SCA == 1)) {


            for (i=0; i<nDetectors; i++) {
                for (j=0; j<nSCAs; j++) {
                    k = i*32 + j;
                    m = i*32 + j;
                    pvGet(mcaROILow[k]);
                    chan = mcaROILow[k];
                    if (chan < 0) chan = 0;
                    if (chan > mcaNumChans[i]-1) chan = mcaNumChans[i]-1;
                    dxpSCALow[m] = chan;
                    pvPut(dxpSCALow[m], SYNC);
                    pvGet(mcaROIHigh[k]);
                    chan = mcaROIHigh[k];
                    if (chan < 0) chan = 0;
                    if (chan > mcaNumChans[i]-1) chan = mcaNumChans[i]-1;
                    dxpSCAHigh[m] = chan;
                    pvPut(dxpSCAHigh[m], SYNC);
                }
            }
            CopyROI_SCA = 0;
            pvPut(CopyROI_SCA, SYNC);
        } state monitor_changes
    }
}
