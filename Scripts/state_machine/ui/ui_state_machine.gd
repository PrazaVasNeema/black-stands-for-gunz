class_name UIStateMachine
extends RefCounted


var current_state : UIState

var states_dictionary : Dictionary


func init(ui_states_array : Array[UIState], initial_state : GameConstants.UI_STATES):
	for ui_state : UIState in ui_states_array:
		states_dictionary[ui_state.state_name] = ui_state
		ui_state.transitioned.connect(on_change_state)
	on_change_state(initial_state)


func on_change_state(new_state: GameConstants.UI_STATES) -> void:
	if current_state:
		current_state.exit()
	current_state = states_dictionary.get(new_state)
	current_state.enter()
