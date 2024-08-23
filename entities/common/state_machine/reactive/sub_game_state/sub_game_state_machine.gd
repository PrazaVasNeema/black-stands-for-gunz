class_name SubGameStateMachine
extends Node

var current_state: SubGameState
var states_dictionary : Dictionary


func init(core) -> void:
	for child in get_children():
		child.core = core
		
		states_dictionary[child.state_type] = child
		(child as SubGameState).transitioned.connect(on_transition_called)
		child.set_views_visibility(false)


func change_state(new_state) -> void:
	if new_state is GameConstants.SUB_GAME_STATES:
		new_state = states_dictionary.get(new_state)

	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()


func on_transition_called(new_state_name : GameConstants.SUB_GAME_STATES) -> void:
	var new_state = states_dictionary.get(new_state_name)
	change_state(new_state)
