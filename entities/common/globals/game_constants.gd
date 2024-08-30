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
	DRUM_WISE = 0b0001,
	GAME_WISE = 0b0010,
	GUN_WISE = 0b0100,
	ENERGY_WISE = 0b1000,
	PLAYER_WISE = 0b10000,
}


enum IMPACT_TYPE {
	DAMAGE,
	HEAL,
	ACTIVATE,
}

class turret_ai:
	const TARGET = &"target"
	const TURRET_QUAT = &"target"
	const QUAT_H = &"target_quat_h"
	const QUAT = &"target_quat"
	const ONLY_STARTS_ROTATING = &"starts_rotating"
	const ANGLE = &"angle"

# Turret AI
