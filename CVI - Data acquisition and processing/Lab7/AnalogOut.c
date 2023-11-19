#include <advanlys.h>
#include "AnalogOut.h"
#include "daqmxioctrl.h"
#include <ansi_c.h>
#include <cvirte.h>     
#include <userint.h>
#include "toolbox.h"
#include <NIDAQmx.h>

static int mainPanel;
TaskHandle taskHandle;
char channel[128];
double *s;
int signal_type;
double min,max,amp,freq;
unsigned int pointsperiod;

int main (int argc, char *argv[])
{
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	/* out of memory */
	if ((mainPanel = LoadPanel (0, "AnalogOut.uir", MAIN_PANEL)) < 0)
		return -1;
	NIDAQmx_NewPhysChanAOCtrl(mainPanel,MAIN_PANEL_IDC_CHANNEL,1);
	DisplayPanel (mainPanel);
	RunUserInterface ();
	DiscardPanel (mainPanel);
	return 0;
}


int32 CVICALLBACK DoneCallback(TaskHandle taskHandle, int32 status, void *callbackData)
{
	return 0;
}

int DAQmxErrChk( int errCode )
{
	if(errCode < 0)
	{
		char errBuff[ 2048 ] = { '\0' };
		DAQmxGetExtendedErrorInfo( errBuff, 2048 );
	}
	return errCode;
}


int CVICALLBACK MainPanelCB (int panel, int event, void *callbackData,
							 int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_GOT_FOCUS:

			break;
		case EVENT_LOST_FOCUS:

			break;
		case EVENT_CLOSE:
			QuitUserInterface (0);
			break;
	}
	return 0;
}

int CVICALLBACK RangeCallback (int panel, int control, int event,
							   void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:

			break;
	}
	return 0;
}

int CVICALLBACK OnGenTimer (int panel, int control, int event,
							void *callbackData, int eventData1, int eventData2)
{
	static int i=0;
	int nw;
	switch (event)
	{
		case EVENT_TIMER_TICK:
				DAQmxWriteAnalogF64(taskHandle,1,0,-1,DAQmx_Val_GroupByChannel,&s[i],&nw,0);
				i=(i+1)%pointsperiod;
				DeleteGraphPlot(panel,MAIN_PANEL_IDC_GRAPH,-1,VAL_IMMEDIATE_DRAW);
				PlotY(panel,MAIN_PANEL_IDC_GRAPH,s,pointsperiod,VAL_DOUBLE,VAL_THIN_LINE,VAL_EMPTY_SQUARE,VAL_SOLID,1,VAL_BLUE);
				//PlotStripChartPoint(panel, MAIN_PANEL_IDC_GRAPH, s[i]);
			break;
	}
	return 0;
}

int CVICALLBACK StartCallback (int panel, int control, int event,
							   void *callbackData, int eventData1, int eventData2)
{
	int val, err;
	double phase =0.0;
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal(panel,MAIN_PANEL_IDC_BTT_START,&val);
			if(val)
			{
				GetCtrlVal(panel,MAIN_PANEL_IDC_MIN,&min);
				GetCtrlVal(panel,MAIN_PANEL_IDC_MAX,&max);
				GetCtrlVal(panel,MAIN_PANEL_IDC_AMPLITUDE,&amp);
				GetCtrlVal(panel,MAIN_PANEL_IDC_FREQUENCY,&freq);
				GetCtrlVal(panel,MAIN_PANEL_IDC_POINTS_PERIOD,&pointsperiod);
				GetCtrlVal(panel,MAIN_PANEL_IDC_CHANNEL,channel);
				s=malloc(pointsperiod*sizeof(double));
				GetCtrlVal(panel,MAIN_PANEL_IDC_SIGNAL_TYPE,&signal_type);
				switch (signal_type)
				{
					case 1:
						SineWave(pointsperiod,amp,1.0/pointsperiod,&phase,s);
						break;
					case 2:
						TriangleWave(pointsperiod,amp,1.0/pointsperiod,&phase,s);
						break;
					case 3:
						SquareWave(pointsperiod,amp,1.0/pointsperiod,&phase,50.0,s);
						break;
					default:
						Ramp(pointsperiod,0,1,s);
						break;
				}
				for(int i=0;i<pointsperiod;i++)
					s[i]+=amp;
				err=DAQmxErrChk( DAQmxCreateTask("", &taskHandle) );
				if(err<0)
					return -1;
				err=DAQmxErrChk(DAQmxCreateAOVoltageChan(taskHandle, channel, "", min, max, DAQmx_Val_Volts, NULL ));
				if(err<0)
					return -1;
				err=DAQmxErrChk( DAQmxRegisterDoneEvent(taskHandle, 0, DoneCallback, NULL ));
				if(err<0)
					return -1;
				err=DAQmxErrChk(DAQmxStartTask(taskHandle));
				if(err<0)
					return -1;
				SetCtrlAttribute(panel,MAIN_PANEL_IDC_GEN_TIMER,ATTR_INTERVAL,1.0/(pointsperiod*freq));
				SetCtrlAttribute(panel,MAIN_PANEL_IDC_GEN_TIMER,ATTR_ENABLED,1);
			}
			else
			{
				SetCtrlAttribute(panel,MAIN_PANEL_IDC_GEN_TIMER,ATTR_ENABLED,0);
				DAQmxStopTask(taskHandle);
				DAQmxClearTask(taskHandle);
				free(s);
			}
			break;
	}
	return 0;
}
