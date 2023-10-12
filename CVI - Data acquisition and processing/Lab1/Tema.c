#include <cvirte.h>		
#include <userint.h>
#include "Tema.h"

static int mainPanel;

int main (int argc, char *argv[])
{
	if (InitCVIRTE (0, argv, 0) == 0)
		return -1;	/* out of memory */
	if ((mainPanel = LoadPanel (0, "Tema.uir", MAIN_PANEL)) < 0)
		return -1;
	DisplayPanel (mainPanel);
	RunUserInterface ();
	DiscardPanel (mainPanel);
	return 0;
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
			if(ConfirmPopup ("Quit", "Do you Really want to quit ?"))
			{
				QuitUserInterface (0);
			}
			break;
	}
	return 0;
}

int CVICALLBACK OnBackgColNum (int panel, int control, int event,
							   void *callbackData, int eventData1, int eventData2)
{
	int val;
	
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal (mainPanel, MAIN_PANEL_BACKG_COLNUM, &val);
			SetCtrlAttribute (mainPanel, MAIN_PANEL_FREQ_TXTBOX, ATTR_TEXT_BGCOLOR, val);
			break;
	}
	return 0;
}

int CVICALLBACK OnFontColNum (int panel, int control, int event,
							  void *callbackData, int eventData1, int eventData2)
{
	int val;
	
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal (mainPanel, MAIN_PANEL_FONT_COLNUM, &val);
			SetCtrlAttribute (mainPanel, MAIN_PANEL_FREQ_TXTBOX, ATTR_TEXT_COLOR, val);
			break;
	}
	return 0;
}



int CVICALLBACK OnBinarySwitch (int panel, int control, int event,
								void *callbackData, int eventData1, int eventData2)
{
	int val;
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal (mainPanel, MAIN_PANEL_BINARY_SWITCH, &val);
			SetCtrlVal (mainPanel, MAIN_PANEL_LED, val);
			break;
	}
	return 0;
}

int CVICALLBACK OnExitButton (int panel, int control, int event,
							  void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			if(ConfirmPopup ("Quit", "Do you Really want to quit ?"))
			{
				QuitUserInterface (0);
			}
			break;
	}
	return 0;
}

int CVICALLBACK OnButton1 (int panel, int control, int event,
						   void *callbackData, int eventData1, int eventData2)
{
	switch (event)
	{
		case EVENT_COMMIT:
			SetCtrlVal (mainPanel, MAIN_PANEL_FREQ_TXTBOX, "1");
			break;
	}
	return 0;
}
