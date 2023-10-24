//==============================================================================
//
// Title:		Signals.c
// Purpose:		A short description of the implementation.
//
// Created on:	21.10.2013 at 12:19:18 by Terran.
// Copyright:	UTI. All Rights Reserved.
//
//==============================================================================

//==============================================================================
// Include files
#include "toolbox.h"
#include <ansi_c.h>
#include <formatio.h>
#include <utility.h>
#include <analysis.h>
#include <userint.h>
#include "Signals.h"
#include "AcquisitionSimulation.h"

//==============================================================================
// Constants

//==============================================================================
// Types

//==============================================================================
// Static global variables
static double rowSignal[ GRAPH_NPOINTS ];
static char fileName[256] = {0};
static int traceColor = VAL_RED;

//==============================================================================
// Static functions

//==============================================================================
// Global variables
int signalType = SIGNALTYPE_SINEWAVE; //tipul semnalului selectat in meniu
int plotHandle = NO_PLOT;  //variabila ce contine handle-ul plotului de pe graph
double amplitude = 5.0;	   //amplitudinea semnalului generat
double frequency = 1.0/113.0; //frecventa de achizitie a semnalului generat
double dutyCycle = 50.0; //factorul de umplere al semnalului dreptunghiular
BOOL saveFlag = FALSE; //flag ce indica daca butonul de salvare a fost apasat

//==============================================================================
// Global functions

/*******************************************************************************
	functia de callback a butonului de achizite
*******************************************************************************/
int CVICALLBACK ManualAcquisitionCB (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	static double phase = 0.0;
	
	switch (event)
	{
		case EVENT_COMMIT:
			//To do: 02
			//*********
			switch (signalType)
			{
				case SIGNALTYPE_SINEWAVE:
					SineWave (GRAPH_NPOINTS, 1.0, 7.8125e-3, &phase, rowSignal);
					break;
				case SIGNALTYPE_TRIANGLEWAVE:
					TriangleWave (GRAPH_NPOINTS, 1.0, 7.8125e-3, &phase, rowSignal);
					break;
				case SIGNALTYPE_SQUAREWAVE:									 
					SquareWave (GRAPH_NPOINTS, 1.0, 7.8125e-3, &phase, 50.0, rowSignal);
					break;
				case SIGNALTYPE_NOISE:
					WhiteNoise (GRAPH_NPOINTS, 1.0, 3, rowSignal);
					break;
			}
			break;
	}
	return 0;
}

/*******************************************************************************
	functia de callback a butonului de afisare
*******************************************************************************/
static int plottHandle;

int CVICALLBACK ManualDisplayCB (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	double maxVal = 0.0;
	double minVal = 0.0;
	int maxIndex = 0;
	int minIndex = 0;
	double mean = 0.0;
				   
	static int count = 0;
	char string[ MAX_PATHNAME_LEN ] = { 0 };
	
	switch (event)
	{
		case EVENT_COMMIT:
			//To do: 03
			//*********
			DeleteGraphPlot (panel, MAIN_PANEL_IDC_GRAPH_DISPLAY, plotHandle, VAL_IMMEDIATE_DRAW);
			plotHandle = PlotY (panel, MAIN_PANEL_IDC_GRAPH_DISPLAY, rowSignal, GRAPH_NPOINTS, VAL_DOUBLE, VAL_THIN_LINE, VAL_EMPTY_SQUARE, VAL_SOLID, 1, VAL_RED);
			
			MaxMin1D(rowSignal, GRAPH_NPOINTS, &maxVal, &maxIndex, &minVal, &minIndex);
			SetCtrlVal (panel, MAIN_PANEL_IDC_NUM_MAX, maxVal);
			SetCtrlVal (panel, MAIN_PANEL_IDC_NUM_MIN, minVal);
			
			Mean(rowSignal, GRAPH_NPOINTS, &mean);

			
			//To do: 08
			//*********
			
			//To do: 06
			//*********
			
			break;
	}
	return 0;
}

/*******************************************************************************
	functia de callback a controlului esantion
*******************************************************************************/
int CVICALLBACK SampleCB (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int val = 0;
	
	switch (event)
	{
		case EVENT_COMMIT:
			//To do: 07
			//*********
			GetCtrlVal (panel, MAIN_PANEL_IDC_NUM_SAMPLE_INDEX, &val);
			SetCursorAttribute (panel, MAIN_PANEL_IDC_GRAPH_DISPLAY, 1, VAL_BOTTOM_XAXIS, val);

			break;
	}
	return 0;
}

/*******************************************************************************
	functia de callback a controalelor color numeric (cursor si trasare)
*******************************************************************************/
int CVICALLBACK OnChooseColorCB (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int val = 0;
	
	switch (event)
	{
		case EVENT_COMMIT:
			//To do: 05
			//*********
			GetCtrlVal (panel, MAIN_PANEL_IDC_COLOR_CURSOR, &val);
			SetCursorAttribute (panel, MAIN_PANEL_IDC_GRAPH_DISPLAY, 1, ATTR_CURSOR_COLOR, val);
			
			GetCtrlVal (panel, MAIN_PANEL_IDC_COLOR_TRACE, &val);
			SetPlotAttribute (panel, MAIN_PANEL_IDC_GRAPH_DISPLAY, plotHandle, ATTR_TRACE_COLOR, val);
			break;
	}
	return 0;
}

/*******************************************************************************
	functia de callback a butoanelor salvare si incarcare
*******************************************************************************/
int CVICALLBACK FileIoCB (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	int val = 0;
	int year = 0;
	int month = 0;
	int day = 0;
	int hour = 0;
	int minute = 0;
	int second = 0;
	char path[MAX_PATHNAME_LEN] = "RowSignal_aaaa.ll.zz_hh-mm-ss.dat";
	
	switch (event)
	{
		case EVENT_COMMIT:
			GetCtrlVal( panel, control, &val );
			
			
			switch( control )
			{
				case MAIN_PANEL_IDC_BTT_FILESAVE:
					//To do: 08
					//*********
					GetSystemDate (&month, &day, &year);
					GetSystemTime (&hour, &minute, &second);
					
					char* aaaa_position = strstr(path, "aaaa");
					if (aaaa_position != NULL)
					{
						char replacement[10];
						snprintf(replacement, sizeof(replacement), "%d", year);
						memmove(aaaa_position + strlen(replacement), aaaa_position + 4, strlen(aaaa_position + 4) + 1);
						strncpy(aaaa_position, replacement, strlen(replacement));
					}

					
					char* ll_position = strstr(path, "ll");
					if (ll_position != NULL)
					{
						char replacement[10];
						snprintf(replacement, sizeof(replacement), "%d", month);
						memmove(ll_position + strlen(replacement), ll_position + 2, strlen(ll_position + 2) + 1);
						strncpy(ll_position, replacement, strlen(replacement));
					}
					
					char* zz_position = strstr(path, "zz");
					if (zz_position != NULL)
					{
						char replacement[10];
						snprintf(replacement, sizeof(replacement), "%d", day);
						memmove(zz_position + strlen(replacement), zz_position + 2, strlen(zz_position + 2) + 1);
						strncpy(zz_position, replacement, strlen(replacement));
					}
					
					char* hh_position = strstr(path, "hh");
					if (hh_position != NULL)
					{
						char replacement[10];
						snprintf(replacement, sizeof(replacement), "%d", hour);
						memmove(hh_position + strlen(replacement), hh_position + 2, strlen(hh_position + 2) + 1);
						strncpy(hh_position, replacement, strlen(replacement));
					}
					
					char* mm_position = strstr(path, "mm");
					if (mm_position != NULL)
					{
						char replacement[10];
						snprintf(replacement, sizeof(replacement), "%d", minute);
						memmove(mm_position + strlen(replacement), mm_position + 2, strlen(mm_position + 2) + 1);
						strncpy(mm_position, replacement, strlen(replacement));
					}
					
					char* ss_position = strstr(path, "ss");
					if (mm_position != NULL)
					{
						char replacement[10];
						snprintf(replacement, sizeof(replacement), "%d", second);
						memmove(ss_position + strlen(replacement), ss_position + 2, strlen(ss_position + 2) + 1);
						strncpy(ss_position, replacement, strlen(replacement));
					}
					
					ArrayToFile (path, rowSignal, VAL_DOUBLE, GRAPH_NPOINTS, 1, VAL_GROUPS_TOGETHER, VAL_GROUPS_AS_COLUMNS, VAL_CONST_WIDTH, 10, VAL_ASCII, VAL_TRUNCATE);
					
					SetCtrlAttribute (panel, MENUBAR_FILE_LOAD, ATTR_DIMMED, val);
					
					break;
				
				case MAIN_PANEL_IDC_BTT_FILELOAD:
					//To do: 09
					//*********

					break;
			}
			break;
	}
	return 0;
}

/*******************************************************************************
	functia de callback a grafului (atunci cand exista un cursor definit)
*******************************************************************************/
int CVICALLBACK GraphDisplayCB (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	double x = 0;
	double y = 0;
	
	switch (event)
	{
		case EVENT_COMMIT:
			//To do: 06
			//*********
			GetGraphCursor (panel, MAIN_PANEL_IDC_GRAPH_DISPLAY, 1, &x, &y);
			SetCtrlVal (panel, MAIN_PANEL_IDC_NUM_SAMPLE_INDEX, x);
			SetCtrlVal (panel, MAIN_PANEL_IDC_NUM_SAMPLE_VALUE, y);
			
			break;
	}
	return 0;
}

/*******************************************************************************
	functia de callback a numeric slide-ului interval de achizitie
*******************************************************************************/
int CVICALLBACK AcquisitionTimerPeriodCB (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	double val = 0.0;
	
	switch (event)
	{
		case EVENT_COMMIT:
			//To do: 04
			//*********
			GetCtrlVal (panel, MAIN_PANEL_IDC_SL_ACQ_PERIOD, &val);
			SetCtrlAttribute (panel, MAIN_PANEL_SIMULATION_TIMER, ATTR_INTERVAL, val);
			
			break;
	}
	return 0;
}

/*******************************************************************************
	functia de callback a timerului de simulare
*******************************************************************************/
int CVICALLBACK OnSimulationTimerCB (int panel, int control, int event,
		void *callbackData, int eventData1, int eventData2)
{
	static double phase = 0.0;
	
	switch (event)
	{
		case EVENT_TIMER_TICK:
			//To do: 04
			//*********
			
			switch (signalType)
		{
			case SIGNALTYPE_SINEWAVE:
				SineWave (GRAPH_NPOINTS, 1.0, 7.8125e-3, &phase, rowSignal);
				break;
			case SIGNALTYPE_TRIANGLEWAVE:
				TriangleWave (GRAPH_NPOINTS, 1.0, 7.8125e-3, &phase, rowSignal);
				break;
			case SIGNALTYPE_SQUAREWAVE:									 
				SquareWave (GRAPH_NPOINTS, 1.0, 7.8125e-3, &phase, 50.0, rowSignal);
				break;
			case SIGNALTYPE_NOISE:
				WhiteNoise (GRAPH_NPOINTS, 1.0, 3, rowSignal);
				break;
		}
		
			DeleteGraphPlot (panel, MAIN_PANEL_IDC_GRAPH_DISPLAY, plotHandle, VAL_IMMEDIATE_DRAW);
			PlotY (panel, MAIN_PANEL_IDC_GRAPH_DISPLAY, rowSignal, GRAPH_NPOINTS, VAL_DOUBLE, VAL_THIN_LINE, VAL_EMPTY_SQUARE, VAL_SOLID, 1, VAL_RED);
			break;
	}
	return 0;
}

