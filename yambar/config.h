#include "icons-in-terminal.h"

#define HEX_COLOR(hex) {                     \
	.red   = ((hex >> 24) & 0xff) * 257, \
	.green = ((hex >> 16) & 0xff) * 257, \
	.blue  = ((hex >>  8) & 0xff) * 257, \
	.alpha = ( hex        & 0xff) * 257  \
}

// use ipc functionality
static bool ipc = false;

// initially hide all bars
static bool hidden = false;

// initially draw all bars at the bottom
static bool bottom = false;

// hide vacant tags
static bool hide_vacant = false;

// vertical pixel padding above and below text
static uint32_t vertical_padding = 1;

// allow in-line color commands in status text
static bool status_commands = true;

// center title text
static bool center_title = false;

// use title space as status text element
static bool custom_title = false;

// title color use active colors
static bool active_color_title = true;

// scale
static uint32_t buffer_scale = 1;

// font
static char *fontstr = "DejaVu Sans Mono:size=12";

// tag names
static char *tags_names[] = {
	SIJI_E1EC, //   terminal
	SIJI_E1A0, //   browser
	SIJI_E1D7, //   work
	SIJI_E181, //   generic
	SIJI_E182, //   generic
	SIJI_E183, //   generic
	SIJI_E184, //   generic
	SIJI_E0C8, //   gaming
	SIJI_E19F, //   chat
};

// set 16-bit colors for bar
// 8-bit color can be converted to 16-bit color by simply duplicating values e.g
// 0x55 -> 0x5555, 0xf1 -> 0xf1f1
static pixman_color_t active_fg_color          = HEX_COLOR(0xfff1c3ff); // bright yellow
static pixman_color_t active_bg_color          = HEX_COLOR(0x000000ff); // bg
static pixman_color_t occupied_fg_color        = HEX_COLOR(0xffffffff); // fg
static pixman_color_t occupied_bg_color        = HEX_COLOR(0x000000ff); // bg
static pixman_color_t inactive_fg_color        = HEX_COLOR(0x616161ff); // dark gray
static pixman_color_t inactive_bg_color        = HEX_COLOR(0x000000ff); // bg
static pixman_color_t urgent_fg_color          = HEX_COLOR(0xff7595ff); // red
static pixman_color_t urgent_bg_color          = HEX_COLOR(0x000000ff); // bg
static pixman_color_t middle_bg_color          = HEX_COLOR(0x000000ff); // bg
static pixman_color_t middle_bg_color_selected = HEX_COLOR(0x000000ff); // bg
