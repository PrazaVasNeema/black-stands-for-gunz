class_name SubGameState
extends R_State

@export var state_type : GameConstants.SUB_GAME_STATES
@export var views_array : Array[Control]


func enter() -> void:
	set_views_visibility(true)


func exit() -> void:
	set_views_visibility(false)


func set_views_visibility(flag : bool):
	for view in views_array:
		view.visible = flag