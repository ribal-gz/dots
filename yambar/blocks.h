#include "icons-in-terminal.h"

// modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/* icon */	/* cmd */	/* update interval */	/* update signal */
	{"^fg(7595ff)^lm(apk-menu)" SIJI_E039 " ", "cat /etc/apk/updatecount",                            60,    0},  /*   updates */
	{"^fg(df75ff)^lm(footclient htop)" SIJI_E021 " ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",     30,    0},  /*   mem */
	{"^fg(95ff75)^lm()" SIJI_E1CD " ", "date '+%b %d (%a)'",                                          60,    0},  /*   date */
	{"^fg(ffdf75)^lm()" SIJI_E015 " ", "date '+%I:%M%p'",                                              5,    0},  /*   time */
};

// sets delimeter between status commands. NULL character ('\0') means no delimeter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
