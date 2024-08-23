class_name GameStateMachine
extends Node

var current_state: GameState


func init(core) -> void:
	for child in get_children():
		child.core = core


# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state) -> void:
	
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
