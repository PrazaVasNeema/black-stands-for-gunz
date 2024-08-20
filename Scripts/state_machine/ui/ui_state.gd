class_name UIState
extends Control

signal transitioned(new_state : GameConstants.UI_STATES)


@export var state_name : GameConstants.UI_STATES

var _g_game_state_controller : GameStateGlobal


func init(g_game_state_controller : GameStateGlobal):
	_g_game_state_controller = g_game_state_controller
	self.visible = false


func enter() -> void:
	self.visible = true


func exit() -> void:
	self.visible = false


func call_transition(new_state : GameConstants.UI_STATES, test = "fghgfh"):
	transitioned.emit(new_state)
	print(test)
