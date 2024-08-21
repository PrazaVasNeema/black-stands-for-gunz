class_name StateMachine
extends Node


var current_state: State


func init(core) -> void:
	for child in get_children():
		child.core = core


# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state: State) -> void:
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()
