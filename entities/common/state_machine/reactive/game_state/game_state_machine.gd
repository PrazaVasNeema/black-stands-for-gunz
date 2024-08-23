class_name GameStateMachine
extends Node

var current_state: GameState
var states_dictionary : Dictionary


func init(core) -> void:
	for child in get_children():
		child.core = core
		states_dictionary[child.state_type] = child
		(child as GameState).transitioned.connect(on_transition_called)
		child.init()
	change_state(GameConstants.GAME_STATES.MAIN_MENUS)


# Change to the new state by first calling any exit logic on the current state.
func change_state(new_state) -> void:
	if new_state is GameConstants.GAME_STATES:
		new_state = states_dictionary.get(new_state)
	
	if current_state:
		current_state.exit()
	current_state = new_state
	current_state.enter()


func on_transition_called(new_state_name : GameConstants.GAME_STATES) -> void:
	var new_state = states_dictionary.get(new_state_name)
	change_state(new_state)
