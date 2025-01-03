class_name GameConstants
extends Node

enum GAME_STATES
{
	MAIN_MENUS,
	INGAME,
}

enum SUB_GAME_STATES
{
	EMPTY,

	MM_MAIN_VIEW,
	MM_OPTIONS_VIEW,
	MM_ARMORY_VIEW,
	MM_POST_GAME_VIEW,

	IG_ACTION,
	IG_PAUSE,
	IG_POST_GAME_VIEW,
}

enum CAMERAS
{
	MAIN_VIEW,
	CABIN_VIEW,
	OPTIONS_VIEW,
}

static var test = 10