extends SubGameState

@export var start_button : BaseButton
@export var how_to_play_button : UI_SubGameTransitionButton
@export var options_button : UI_SubGameTransitionButton


func _ready() -> void:
	start_button.pressed.connect(_start_game)
	options_button.change_state.connect(call_transition)
	how_to_play_button.change_state.connect(call_transition)


func enter() -> void:
	super()
	G_CamerasManager.set_current(GameConstants.CAMERAS.MAIN_VIEW)


func _start_game():
	core.call_transition(GameConstants.GAME_STATES.IN_GAME)
