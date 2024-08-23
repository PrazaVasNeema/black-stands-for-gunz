class_name SubGameState
extends Node

signal transitioned(new_state_name : GameConstants.SUB_GAME_STATES)

@export var state_type : GameConstants.SUB_GAME_STATES
@export var views_array : Array[Control]

var core : GameState


func enter() -> void:
	set_views_visibility(true)


func exit() -> void:
	set_views_visibility(false)


func call_transition(new_state_name : GameConstants.SUB_GAME_STATES):
	transitioned.emit(new_state_name)


func set_views_visibility(flag : bool):
	for view in views_array:
		view.visible = flag
