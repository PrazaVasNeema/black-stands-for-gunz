class_name R_StateMachine
extends StateMachine

var states_dictionary : Dictionary


func init(core) -> void:
	super(core)
	for child in get_children():
		states_dictionary[child.state_type] = child
		(child as R_State).transitioned.connect(on_transition_called)


func on_transition_called(new_state_name) -> void:
	var new_state = states_dictionary.get(new_state_name)
	change_state(new_state)
