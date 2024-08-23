class_name InGame
extends GameState


func enter():
	super()
	G_CamerasManager.set_current(GameConstants.CAMERAS.CABIN_VIEW)


func exit():
	super()
	sub_game_state_machine.on_change_state(GameConstants.SUB_GAME_STATES.EMPTY)
