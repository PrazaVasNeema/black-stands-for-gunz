class_name MainMenus
extends GameState

@export var default_state : GameConstants.SUB_GAME_STATES


func enter() -> void:
	super()
	sub_game_state_machine.change_state(default_state)


func exit() -> void:
	super()
	sub_game_state_machine.change_state(GameConstants.SUB_GAME_STATES.EMPTY)
