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
# 37 "../dxpMED.st"
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
int prevAutoApply;
double energy;
double slope;

char *prefix;
char *dxp;
char *mca;

double TriggerPeakingTime[100];
assign TriggerPeakingTime to {};
int CopyTriggerPeakingTime; assign CopyTriggerPeakingTime to "{P}CopyTriggerPeakingTime";
monitor CopyTriggerPeakingTime; evflag CopyTriggerPeakingTimeMon; sync CopyTriggerPeakingTime CopyTriggerPeakingTimeMon;

double TriggerGapTime[100];
assign TriggerGapTime to {};

int CopyTriggerGapTime; assign CopyTriggerGapTime to "{P}CopyTriggerGapTime";
monitor CopyTriggerGapTime; evflag CopyTriggerGapTimeMon; sync CopyTriggerGapTime CopyTriggerGapTimeMon;

double TriggerThreshold[100];
assign TriggerThreshold to {};
int CopyTriggerThreshold; assign CopyTriggerThreshold to "{P}CopyTriggerThreshold";
monitor CopyTriggerThreshold; evflag CopyTriggerThresholdMon; sync CopyTriggerThreshold CopyTriggerThresholdMon;

double PeakingTime[100];
assign PeakingTime to {};
int CopyPeakingTime; assign CopyPeakingTime to "{P}CopyPeakingTime";
monitor CopyPeakingTime; evflag CopyPeakingTimeMon; sync CopyPeakingTime CopyPeakingTimeMon;

double GapTime[100];
assign GapTime to {};
int CopyGapTime; assign CopyGapTime to "{P}CopyGapTime";
monitor CopyGapTime; evflag CopyGapTimeMon; sync CopyGapTime CopyGapTimeMon;

double EnergyThreshold[100];
assign EnergyThreshold to {};
int CopyEnergyThreshold; assign CopyEnergyThreshold to "{P}CopyEnergyThreshold";
monitor CopyEnergyThreshold; evflag CopyEnergyThresholdMon; sync CopyEnergyThreshold CopyEnergyThresholdMon;

double MaxWidth[100];
assign MaxWidth to {};
int CopyMaxWidth; assign CopyMaxWidth to "{P}CopyMaxWidth";
monitor CopyMaxWidth; evflag CopyMaxWidthMon; sync CopyMaxWidth CopyMaxWidthMon;

double BaselineCutPercent[100];
assign BaselineCutPercent to {};
int CopyBaselineCutPercent; assign CopyBaselineCutPercent to "{P}CopyBaselineCutPercent";
monitor CopyBaselineCutPercent; evflag CopyBaselineCutPercentMon; sync CopyBaselineCutPercent CopyBaselineCutPercentMon;

double BaselineCutEnable[100];
assign BaselineCutEnable to {};
int CopyBaselineCutEnable; assign CopyBaselineCutEnable to "{P}CopyBaselineCutEnable";
monitor CopyBaselineCutEnable; evflag CopyBaselineCutEnableMon; sync CopyBaselineCutEnable CopyBaselineCutEnableMon;

double BaselineThreshold[100];
assign BaselineThreshold to {};
int CopyBaselineThreshold; assign CopyBaselineThreshold to "{P}CopyBaselineThreshold";
monitor CopyBaselineThreshold; evflag CopyBaselineThresholdMon; sync CopyBaselineThreshold CopyBaselineThresholdMon;

double BaselineFilterLength[100];
assign BaselineFilterLength to {};
int CopyBaselineFilterLength; assign CopyBaselineFilterLength to "{P}CopyBaselineFilterLength";
monitor CopyBaselineFilterLength; evflag CopyBaselineFilterLengthMon; sync CopyBaselineFilterLength CopyBaselineFilterLengthMon;

double PreampGain[100];
assign PreampGain to {};
int CopyPreampGain; assign CopyPreampGain to "{P}CopyPreampGain";
monitor CopyPreampGain; evflag CopyPreampGainMon; sync CopyPreampGain CopyPreampGainMon;

int DetectorPolarity[100];
assign DetectorPolarity to {};
int CopyDetectorPolarity; assign CopyDetectorPolarity to "{P}CopyDetectorPolarity";
monitor CopyDetectorPolarity; evflag CopyDetectorPolarityMon; sync CopyDetectorPolarity CopyDetectorPolarityMon;

double ResetDelay[100];
assign ResetDelay to {};
int CopyResetDelay; assign CopyResetDelay to "{P}CopyResetDelay";
monitor CopyResetDelay; evflag CopyResetDelayMon; sync CopyResetDelay CopyResetDelayMon;

double DecayTime[100];
assign DecayTime to {};
int CopyDecayTime; assign CopyDecayTime to "{P}CopyDecayTime";
monitor CopyDecayTime; evflag CopyDecayTimeMon; sync CopyDecayTime CopyDecayTimeMon;

double MaxEnergy[100];
assign MaxEnergy to {};
int CopyMaxEnergy; assign CopyMaxEnergy to "{P}CopyMaxEnergy";
monitor CopyMaxEnergy; evflag CopyMaxEnergyMon; sync CopyMaxEnergy CopyMaxEnergyMon;

double ADCPercentRule[100];
assign ADCPercentRule to {};
int CopyADCPercentRule; assign CopyADCPercentRule to "{P}CopyADCPercentRule";
monitor CopyADCPercentRule; evflag CopyADCPercentRuleMon; sync CopyADCPercentRule CopyADCPercentRuleMon;

int ReadBaselineHistogram[100];
assign ReadBaselineHistogram to {};
int ReadBaselineHistograms; assign ReadBaselineHistograms to "{P}DoReadBaselineHistograms";
monitor ReadBaselineHistograms; evflag ReadBaselineHistogramsMon; sync ReadBaselineHistograms ReadBaselineHistogramsMon;

int ReadTrace[100];
assign ReadTrace to {};
int ReadTraces; assign ReadTraces to "{P}DoReadTraces";
monitor ReadTraces; evflag ReadTracesMon; sync ReadTraces ReadTracesMon;

double TraceTime[100];
assign TraceTime to {};
double TraceTimes; assign TraceTimes to "{P}TraceTimes";
monitor TraceTimes; evflag TraceTimesMon; sync TraceTimes TraceTimesMon;

int TraceMode[100];
assign TraceMode to {};
int TraceModes; assign TraceModes to "{P}TraceModes";
monitor TraceModes; evflag TraceModesMon; sync TraceModes TraceModesMon;

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

double mcaPresetLive[100];
assign mcaPresetLive to {};
double PresetLive; assign PresetLive to "{P}PresetLive";
monitor PresetLive; evflag PresetLiveMon; sync PresetLive PresetLiveMon;

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
int AutoApply; assign AutoApply to "{P}AutoApply"; monitor AutoApply;
int Apply; assign Apply to "{P}Apply";

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
                sprintf(temp, "%s%s%d:TriggerPeakingTime", prefix, dxp, det);
                pvAssign(TriggerPeakingTime[i], temp);

                sprintf(temp, "%s%s%d:TriggerGapTime", prefix, dxp, det);
                pvAssign(TriggerGapTime[i], temp);

                sprintf(temp, "%s%s%d:TriggerThreshold", prefix, dxp, det);
                pvAssign(TriggerThreshold[i], temp);

                sprintf(temp, "%s%s%d:PeakingTime", prefix, dxp, det);
                pvAssign(PeakingTime[i], temp);

                sprintf(temp, "%s%s%d:GapTime", prefix, dxp, det);
                pvAssign(GapTime[i], temp);

                sprintf(temp, "%s%s%d:EnergyThreshold", prefix, dxp, det);
                pvAssign(EnergyThreshold[i], temp);

                sprintf(temp, "%s%s%d:MaxWidth", prefix, dxp, det);
                pvAssign(MaxWidth[i], temp);

                sprintf(temp, "%s%s%d:BaselineCutPercent", prefix, dxp, det);
                pvAssign(BaselineCutPercent[i], temp);

                sprintf(temp, "%s%s%d:BaselineCutEnable", prefix, dxp, det);
                pvAssign(BaselineCutEnable[i], temp);

                sprintf(temp, "%s%s%d:BaselineThreshold", prefix, dxp, det);
                pvAssign(BaselineThreshold[i], temp);

                sprintf(temp, "%s%s%d:BaselineFilterLength", prefix, dxp, det);
                pvAssign(BaselineFilterLength[i], temp);

                sprintf(temp, "%s%s%d:PreampGain", prefix, dxp, det);
                pvAssign(PreampGain[i], temp);

                sprintf(temp, "%s%s%d:DetectorPolarity", prefix, dxp, det);
                pvAssign(DetectorPolarity[i], temp);

                sprintf(temp, "%s%s%d:ResetDelay", prefix, dxp, det);
                pvAssign(ResetDelay[i], temp);

                sprintf(temp, "%s%s%d:DecayTime", prefix, dxp, det);
                pvAssign(DecayTime[i], temp);

                sprintf(temp, "%s%s%d:MaxEnergy", prefix, dxp, det);
                pvAssign(MaxEnergy[i], temp);

                sprintf(temp, "%s%s%d:ADCPercentRule", prefix, dxp, det);
                pvAssign(ADCPercentRule[i], temp);

                sprintf(temp, "%s%s%d:BaselineHistogram.PROC", prefix, dxp, det);
                pvAssign(ReadBaselineHistogram[i], temp);

                sprintf(temp, "%s%s%d:TraceData.PROC", prefix, dxp, det);
                pvAssign(ReadTrace[i], temp);

                sprintf(temp, "%s%s%d:TraceTime", prefix, dxp, det);
                pvAssign(TraceTime[i], temp);

                sprintf(temp, "%s%s%d:TraceMode", prefix, dxp, det);
                pvAssign(TraceMode[i], temp);

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

                sprintf(temp, "%s%s%d.PLTM", prefix, mca, det);
                pvAssign(mcaPresetLive[i], temp);

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

        when(efTestAndClear(CopyTriggerPeakingTimeMon) && (CopyTriggerPeakingTime == 1)) {
            pvGet(TriggerPeakingTime[0]);
            for (i=0; i<nDetectors; i++) {
                TriggerPeakingTime[i] = TriggerPeakingTime[0];
                pvPut(TriggerPeakingTime[i]);
            }
            CopyTriggerPeakingTime = 0;
            pvPut(CopyTriggerPeakingTime);
        } state monitor_changes

        when(efTestAndClear(CopyTriggerGapTimeMon) && (CopyTriggerGapTime == 1)) {
            pvGet(TriggerGapTime[0]);
            for (i=0; i<nDetectors; i++) {
                TriggerGapTime[i] = TriggerGapTime[0];
                pvPut(TriggerGapTime[i]);
            }
            CopyTriggerGapTime = 0;
            pvPut(CopyTriggerGapTime);
        } state monitor_changes

        when(efTestAndClear(CopyTriggerThresholdMon) && (CopyTriggerThreshold == 1)) {
            pvGet(TriggerThreshold[0]);
            for (i=0; i<nDetectors; i++) {
                TriggerThreshold[i] = TriggerThreshold[0];
                pvPut(TriggerThreshold[i]);
            }
            CopyTriggerThreshold = 0;
            pvPut(CopyTriggerThreshold);
        } state monitor_changes

        when(efTestAndClear(CopyPeakingTimeMon) && (CopyPeakingTime == 1)) {
            pvGet(PeakingTime[0]);
            for (i=0; i<nDetectors; i++) {
                PeakingTime[i] = PeakingTime[0];
                pvPut(PeakingTime[i]);
            }
            CopyPeakingTime = 0;
            pvPut(CopyPeakingTime);
        } state monitor_changes

        when(efTestAndClear(CopyGapTimeMon) && (CopyGapTime == 1)) {
            pvGet(GapTime[0]);
            for (i=0; i<nDetectors; i++) {
                GapTime[i] = GapTime[0];
                pvPut(GapTime[i]);
            }
            CopyGapTime = 0;
            pvPut(CopyGapTime);
        } state monitor_changes

        when(efTestAndClear(CopyEnergyThresholdMon) && (CopyEnergyThreshold == 1)) {
            pvGet(EnergyThreshold[0]);
            for (i=0; i<nDetectors; i++) {
                EnergyThreshold[i] = EnergyThreshold[0];
                pvPut(EnergyThreshold[i]);
            }
            CopyEnergyThreshold = 0;
            pvPut(CopyEnergyThreshold);
        } state monitor_changes

        when(efTestAndClear(CopyMaxWidthMon) && (CopyMaxWidth == 1)) {
            pvGet(MaxWidth[0]);
            for (i=0; i<nDetectors; i++) {
                MaxWidth[i] = MaxWidth[0];
                pvPut(MaxWidth[i]);
            }
            CopyMaxWidth = 0;
            pvPut(CopyMaxWidth);
        } state monitor_changes

        when(efTestAndClear(CopyBaselineCutPercentMon) && (CopyBaselineCutPercent == 1)) {
            pvGet(BaselineCutPercent[0]);
            for (i=0; i<nDetectors; i++) {
                BaselineCutPercent[i] = BaselineCutPercent[0];
                pvPut(BaselineCutPercent[i]);
            }
            CopyBaselineCutPercent = 0;
            pvPut(CopyBaselineCutPercent);
        } state monitor_changes

        when(efTestAndClear(CopyBaselineCutEnableMon) && (CopyBaselineCutEnable == 1)) {
            pvGet(BaselineCutEnable[0]);
            for (i=0; i<nDetectors; i++) {
                BaselineCutEnable[i] = BaselineCutEnable[0];
                pvPut(BaselineCutEnable[i]);
            }
            CopyBaselineCutEnable = 0;
            pvPut(CopyBaselineCutEnable);
        } state monitor_changes

        when(efTestAndClear(CopyBaselineThresholdMon) && (CopyBaselineThreshold == 1)) {
            pvGet(BaselineThreshold[0]);
            for (i=0; i<nDetectors; i++) {
                BaselineThreshold[i] = BaselineThreshold[0];
                pvPut(BaselineThreshold[i]);
            }
            CopyBaselineThreshold = 0;
            pvPut(CopyBaselineThreshold);
        } state monitor_changes

        when(efTestAndClear(CopyBaselineFilterLengthMon) && (CopyBaselineFilterLength == 1)) {
            pvGet(BaselineFilterLength[0]);
            for (i=0; i<nDetectors; i++) {
                BaselineFilterLength[i] = BaselineFilterLength[0];
                pvPut(BaselineFilterLength[i]);
            }
            CopyBaselineFilterLength = 0;
            pvPut(CopyBaselineFilterLength);
        } state monitor_changes

        when(efTestAndClear(CopyPreampGainMon) && (CopyPreampGain == 1)) {
            pvGet(PreampGain[0]);
            for (i=0; i<nDetectors; i++) {
                PreampGain[i] = PreampGain[0];
                pvPut(PreampGain[i]);
            }
            CopyPreampGain = 0;
            pvPut(CopyPreampGain);
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

        when(efTestAndClear(CopyResetDelayMon) && (CopyResetDelay == 1)) {
            pvGet(ResetDelay[0]);
            for (i=0; i<nDetectors; i++) {
                ResetDelay[i] = ResetDelay[0];
                pvPut(ResetDelay[i]);
            }
            CopyResetDelay = 0;
            pvPut(CopyResetDelay);
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

        when(efTestAndClear(CopyMaxEnergyMon) && (CopyMaxEnergy == 1)) {
            pvGet(MaxEnergy[0]);
            for (i=0; i<nDetectors; i++) {
                MaxEnergy[i] = MaxEnergy[0];
                pvPut(MaxEnergy[i]);
            }
            CopyMaxEnergy = 0;
            pvPut(CopyMaxEnergy);
        } state monitor_changes

        when(efTestAndClear(CopyADCPercentRuleMon) && (CopyADCPercentRule == 1)) {
            pvGet(ADCPercentRule[0]);
            for (i=0; i<nDetectors; i++) {
                ADCPercentRule[i] = ADCPercentRule[0];
                pvPut(ADCPercentRule[i]);
            }
            CopyADCPercentRule = 0;
            pvPut(CopyADCPercentRule);
        } state monitor_changes

        when(efTestAndClear(ReadBaselineHistogramsMon) && (ReadBaselineHistograms == 1)) {
            for (i=0; i<nDetectors; i++) {
                ReadBaselineHistogram[i] = 1;
                pvPut(ReadBaselineHistogram[i]);
            }
            ReadBaselineHistograms = 0;
            pvPut(ReadBaselineHistograms);
        } state monitor_changes

        when(efTestAndClear(ReadTracesMon) && (ReadTraces == 1)) {
            for (i=0; i<nDetectors; i++) {
                ReadTrace[i] = 1;
                pvPut(ReadTrace[i]);
            }
            ReadTraces = 0;
            pvPut(ReadTraces);
        } state monitor_changes

        when(efTestAndClear(TraceTimesMon)) {
            for (i=0; i<nDetectors; i++) {
                TraceTime[i] = TraceTimes;
                pvPut(TraceTime[i]);
            }
        } state monitor_changes

        when(efTestAndClear(TraceModesMon)) {
            for (i=0; i<nDetectors; i++) {
                TraceMode[i] = TraceModes;
                pvPut(TraceMode[i]);
            }
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

        when(efTestAndClear(PresetLiveMon)) {
            for (i=0; i<nDetectors; i++) {
                mcaPresetLive[i] = PresetLive;
                pvPut(mcaPresetLive[i]);
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




            prevAutoApply = AutoApply;
            AutoApply = 0;
            pvPut(AutoApply, SYNC);
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

            Apply = 1;
            pvPut(Apply, SYNC);

            AutoApply = prevAutoApply;
            pvPut(AutoApply, SYNC);
            CopyROI_SCA = 0;
            pvPut(CopyROI_SCA, SYNC);
        } state monitor_changes
    }
}
