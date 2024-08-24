class_name GameConstants
extends Object

enum GAME_STATES
{
	MAIN_MENUS,
	IN_GAME,
}

enum SUB_GAME_STATES
{
	EMPTY,

	MM_MAIN_VIEW,
	MM_OPTIONS_VIEW,
	MM_HOW_TO_PLAY,
	MM_OPTIONS_LANGUAGE,

	IG_ACTION,
	IG_PAUSE,
	IG_POST_GAME_VIEW,
}

enum CAMERAS
{
	MAIN_VIEW,
	CABIN_VIEW,
	OPTIONS_VIEW,
	HOW_TO_PLAY_VIEW,
}

static var test = 10

enum GUN_CHECKS {
	DRUM_WISE = 0b001,
	GAME_WISE = 0b010,
	GUN_WISE = 0b010,
}
