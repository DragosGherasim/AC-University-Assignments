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
#define  MAIN_PANEL_GRAPH                 2       /* control type: graph, callback function: OnGraph */
#define  MAIN_PANEL_MODACZ_BINARYSWITCH   3       /* control type: binary, callback function: (none) */
#define  MAIN_PANEL_RETEA_BINARYSWITCH    4       /* control type: binary, callback function: OnReteaSwitch */
#define  MAIN_PANEL_LED                   5       /* control type: LED, callback function: (none) */
#define  MAIN_PANEL_DECORATION            6       /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_DECORATION_3          7       /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_DECORATION_7          8       /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_DECORATION_6          9       /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_DECORATION_4          10      /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_DECORATION_2          11      /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_AFIS_COMMANDBUTTON    12      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_ACZ_COMMANDBUTTON     13      /* control type: command, callback function: (none) */
#define  MAIN_PANEL_TRASARE_COLORNUM      14      /* control type: color, callback function: (none) */
#define  MAIN_PANEL_CURSOR_COLORNUM       15      /* control type: color, callback function: (none) */
#define  MAIN_PANEL_ESANTION_NUM          16      /* control type: numeric, callback function: (none) */
#define  MAIN_PANEL_VALOARE_STR           17      /* control type: string, callback function: (none) */
#define  MAIN_PANEL_TEXTMSG               18      /* control type: textMsg, callback function: (none) */
#define  MAIN_PANEL_DECORATION_5          19      /* control type: deco, callback function: (none) */
#define  MAIN_PANEL_TEXTMSG_3             20      /* control type: textMsg, callback function: (none) */
#define  MAIN_PANEL_TEXTMSG_2             21      /* control type: textMsg, callback function: (none) */
#define  MAIN_PANEL_SALVARE_TGGLBUTTON    22      /* control type: textButton, callback function: (none) */
#define  MAIN_PANEL_INCARCA_TGGLBUTTON    23      /* control type: textButton, callback function: (none) */
#define  MAIN_PANEL_MAXIM_STRG            24      /* control type: string, callback function: (none) */
#define  MAIN_PANEL_MEDIE_STRG            25      /* control type: string, callback function: (none) */
#define  MAIN_PANEL_MINIM_STRG            26      /* control type: string, callback function: (none) */
#define  MAIN_PANEL_INTERV_ACHIZ_NUMSLIDE 27      /* control type: scale, callback function: (none) */


     /* Control Arrays: */

          /* (no control arrays in the resource file) */


     /* Menu Bars, Menus, and Menu Items: */

#define  MENUBAR                          1
#define  MENUBAR_FILE_MENU                2
#define  MENUBAR_FILE_MENU_NEW_MENU_ITEM  3
#define  MENUBAR_FILE_MENU_LOAD_MENU_ITEM 4
#define  MENUBAR_FILE_MENU_SAVE_MENU_ITEM 5
#define  MENUBAR_HELP_MENU                6
#define  MENUBAR_HELP_MENU_ABOUT_MENU_ITEM 7      /* callback function: OnAboutMenuItem */
#define  MENUBAR_EXIT_MENU_ITEM           8       /* callback function: OnExitMenuItem */


     /* Callback Prototypes: */

void CVICALLBACK OnAboutMenuItem(int menubar, int menuItem, void *callbackData, int panel);
void CVICALLBACK OnExitMenuItem(int menubar, int menuItem, void *callbackData, int panel);
int  CVICALLBACK OnGraph(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK OnMainPanel(int panel, int event, void *callbackData, int eventData1, int eventData2);
int  CVICALLBACK OnReteaSwitch(int panel, int control, int event, void *callbackData, int eventData1, int eventData2);


#ifdef __cplusplus
    }
#endif