/**************************************************************************/
/* LabWindows/CVI User Interface Resource (UIR) Include File              */
/*                                                                        */
/* WARNING: Do not add to, delete from, or otherwise modify the contents  */
/*          of this include file.                                         */
/**************************************************************************/

#include <userint.h>

#ifdef __cplusplus
    extern "C" {
#endif

     /* Panels and Controls: */

#define  MAIN_PANEL                       1       /* callback function: OnMainPanel */
#define  MAIN_PANEL_FREQ_TXTBOX           2       /* control type: string, callback function: (none) */
#define  MAIN_PANEL_FONT_COLNUM           3       /* control type: color, callback function: OnFontColNum */
#define  MAIN_PANEL_BACKG_COLNUM          4       /* control type: color, callback function: OnBackgColNum */
#define  MAIN_PANEL_DECORATION            5       /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_NUMERICKNOB_2         6       /* control type: scale, callback function: (none) */
#define  MAIN_PANEL_NUMERICKNOB           7       /* control type: scale, callback function: (none) */
#define  MAIN_PANEL_BINARY_SWITCH         8       /* control type: binary, callback function: OnBinarySwitch */
#define  MAIN_PANEL_LED                   9       /* control type: LED, callback function: (none) */
#define  MAIN_PANEL_DECORATION_3          10      /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_EXIT_BUTTON           11      /* control type: command, callback function: OnExitButton */
#define  MAIN_PANEL_DECORATION_4          12      /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_10      13      /* control type: command, callback function: OnButton1 */
#define  MAIN_PANEL_DECORATION_2          14      /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_24      15      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_23      16      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_22      17      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_21      18      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_20      19      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_19      20      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_18      21      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_17      22      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_16      23      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_15      24      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_14      25      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_13      26      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_12      27      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_COMMANDBUTTON_11      28      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_RINGSLIDE             29      /* control type: slide, callback function: (none) */
#define  MAIN_PANEL_DECORATION_5          30      /* control type: deco, callback function: (none) */


     /* Control Arrays: */

          /* (no control arrays in the resource file) */


     /* Menu Bars, Menus, and Menu Items: */

          /* (no menu bars in the resource file) */


     /* Callback Prototypes: */

int  CVICALLBACK OnBackgColNum(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK OnBinarySwitch(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK OnButton1(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK OnExitButton(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK OnFontColNum(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK OnMainPanel(int panel, int event, void *callbackData, int eventData1, int eventData2);


#ifdef __cplusplus
    }
#endif