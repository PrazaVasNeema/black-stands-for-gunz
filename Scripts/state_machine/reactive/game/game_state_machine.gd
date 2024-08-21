class_name GameStateMachine
extends R_StateMachine


func init(core) -> void:
	super(core)
	for child in get_children():
		child.init()
	on_change_state(GameConstants.GAME_STATES.MAIN_MENUS)


func on_change_state(new_state: GameConstants.GAME_STATES) -> void:
	if current_state:
		current_state.exit()
	current_state = states_dictionary.get(new_state)
	current_state.enter()