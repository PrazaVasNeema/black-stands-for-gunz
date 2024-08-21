class_name MM_GameState
extends GameState

@export var default_state : GameConstants.SUB_GAME_STATES


func enter() -> void:
    super()
    sub_game_state_machine.on_change_state(default_state)


func exit() -> void:
    super()
    sub_game_state_machine.on_change_state(GameConstants.SUB_GAME_STATES.EMPTY)
