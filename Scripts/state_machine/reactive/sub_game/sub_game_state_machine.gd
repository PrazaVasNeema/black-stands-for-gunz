class_name SubGameStateMachine
extends R_StateMachine


func init(core):
	super(core)
	for child : SubGameState in get_children():
		child.set_views_visibility(false)


func on_change_state(new_state: GameConstants.SUB_GAME_STATES) -> void:
	if current_state:
		current_state.exit()
	current_state = states_dictionary.get(new_state)
	current_state.enter()
