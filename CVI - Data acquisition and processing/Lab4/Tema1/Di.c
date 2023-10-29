#include <cvirte.h>		
#include <userint.h>
#include "Di.h"
#include "daqmxioctrl.h"
#include <NIDAQmx.h>

static int diPanel;
static TaskHandle taskHandle;

int main (int argc, char *argv[])
{
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	/* out of memory */
	if ((diPanel = LoadPanel (0, "Di.uir", DI_PANEL)) < 0)
		return -1;
	
	NIDAQmx_NewPhysChanDIPortCtrl (diPanel, DI_PANEL_IDC_DI_CHANNEL, 1);
	
	DisplayPanel (diPanel);
	RunUserInterface ();
	DiscardPanel (diPanel);
	
	return 0;
}

int CVICALLBACK OnDiPanelCB (int panel, int event, void *callbackData,
							 int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_GOT_FOCUS:

			break;
		case EVENT_LOST_FOCUS:

			break;
		case EVENT_CLOSE:
			QuitUserInterface(0);
			
			break;
	}
	return 0;
}

static uInt8 valori[4];

int CVICALLBACK OnDiButtonRead (int panel, int control, int event,
								void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		int32 writeArray;
		case EVENT_COMMIT:
			DAQmxReadDigitalU8 (taskHandle, 1, 10.0, DAQmx_Val_GroupByChannel, valori, 4, &writeArray, NULL);
			
			SetCtrlVal (diPanel, DI_PANEL_IDC_KEY_LED_0, valori[0]);
			SetCtrlVal (diPanel, DI_PANEL_IDC_KEY_LED_1, valori[1]);
			SetCtrlVal (diPanel, DI_PANEL_IDC_KEY_LED_2, valori[2]);
			SetCtrlVal (diPanel, DI_PANEL_IDC_KEY_LED_3, valori[3]);
			
			SetCtrlVal (diPanel, DI_PANEL_IDC_DI_VALUE, 
					   valori[0] | valori[1] | valori[2] | valori[3]);
			break;
	}
	return 0;
}

int CVICALLBACK OnDiButtonStart (int panel, int control, int event,
								 void *callbackData, int eventData1, int eventData2)
{
	
	int val = 0;	
	char channel[100];
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal (diPanel, DI_PANEL_IDC_DI_START, &val);
			
			if(val == 1)
			{
				GetCtrlVal (diPanel, DI_PANEL_IDC_DI_CHANNEL, channel);
				DAQmxCreateTask("", &taskHandle);
				DAQmxCreateDIChan(taskHandle, channel, "", DAQmx_Val_ChanForAllLines);
				DAQmxStartTask(taskHandle);
			}
			else if(val == 0)
			{
				DAQmxStopTask(taskHandle);
			}
		
			break;
	}
	return 0;
}

int CVICALLBACK OnDiKeyTimer (int panel, int control, int event,
							  void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_TIMER_TICK:

			break;
	}
	return 0;
}
