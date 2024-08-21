class_name GameState
extends R_State

@export var state_type : GameConstants.GAME_STATES
@export var sub_game_state_machine : SubGameStateMachine
@export var ui_root : Control


func init() -> void :
	ui_root.visible = false
	sub_game_state_machine.init(self)


func enter():
	super()
	ui_root.visible = true


func exit():
	super()
	ui_root.visible = false
