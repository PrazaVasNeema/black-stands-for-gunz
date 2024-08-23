extends SubGameState

@export var continue_button : UI_SubGameTransitionButton
@export var exit_button : UI_SubGameTransitionButton


func _ready() -> void:
	continue_button.change_state.connect(call_transition)
	exit_button.change_state.connect(call_transition)


func enter() -> void:
	super()
	G_InputService.pause_pressed.connect(call_transition.bind(GameConstants.SUB_GAME_STATES.IG_ACTION))


func exit():
	super()
	G_InputService.pause_pressed.disconnect(call_transition.bind(GameConstants.SUB_GAME_STATES.IG_ACTION))
