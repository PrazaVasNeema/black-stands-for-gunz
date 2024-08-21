class_name IG_GameState
extends GameState

@export var gameplaye_player_shogun : GameplayPlayerShogun


func init() -> void :
	super()
	gameplaye_player_shogun.init()


func enter():
	super()
	G_CamerasManager.set_current(GameConstants.CAMERAS.CABIN_VIEW)
	sub_game_state_machine.on_change_state(GameConstants.SUB_GAME_STATES.IG_ACTION)
	gameplaye_player_shogun.lock_n_load()


func exit():
	super()
	sub_game_state_machine.on_change_state(GameConstants.SUB_GAME_STATES.EMPTY)