#include <cvirte.h>		
#include <userint.h>
#include "MainUIR.h"

static int mainPanel;

int main (int argc, char *argv[])
{
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	/* out of memory */
	if ((mainPanel = LoadPanel (0, "MainUIR.uir", MAIN_PANEL)) < 0)
		return -1;
	DisplayPanel (mainPanel);
	RunUserInterface ();
	DiscardPanel (mainPanel);
	return 0;
}

void QuitUserInterfaceConfirm()
{
	if(ConfirmPopup("Quit", "Do you really want to quit?"))
	{
		QuitUserInterface (0);
	}
}

int CVICALLBACK OnMainPanel (int panel, int event, void *callbackData,
							 int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_GOT_FOCUS:

			break;
		case EVENT_LOST_FOCUS:

			break;
		case EVENT_CLOSE:
			QuitUserInterfaceConfirm();
			
			break;
	}
	return 0;
}

void CVICALLBACK OnExitMenuItem (int menuBar, int menuItem, void *callbackData,
								 int panel)
{
	QuitUserInterfaceConfirm();
}

void CVICALLBACK OnAboutMenuItem (int menuBar, int menuItem, void *callbackData,
								  int panel)
{
	MessagePopup("About", "Created by Dani@1306A on 10/10/2023");
}

int CVICALLBACK OnGraph (int panel, int control, int event,
						 void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:

			break;
	}
	return 0;
}

int CVICALLBACK OnReteaSwitch (int panel, int control, int event,
							   void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			int val = 0;
			GetCtrlVal(mainPanel, MAIN_PANEL_RETEA_BINARYSWITCH, &val);
			SetCtrlVal(mainPanel, MAIN_PANEL_LED, val);
			
			break;
	}
	return 0;
}
