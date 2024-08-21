class_name GameState
extends R_State

@export var state_type : GameConstants.SUB_GAME_STATES
@export var sub_game_state_machine : SubGameStateMachine


func init() -> void :
    sub_game_state_machine.init(self)