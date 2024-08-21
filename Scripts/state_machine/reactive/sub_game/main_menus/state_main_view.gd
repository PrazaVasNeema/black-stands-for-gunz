extends SubGameState


@export var start_button : BaseButton
@export var options_button : UI_ChangeStateButton
@export var quit_button : BaseButton
@export var armory_button : UI_ChangeStateButton


func _ready() -> void:
	options_button.change_state.connect(call_transition)
	armory_button.change_state.connect(call_transition)
	start_button.pressed.connect(_start_game)
	quit_button.pressed.connect(_quit_game)


func enter() -> void:
	super()
	G_CamerasManager.set_current(GameConstants.CAMERAS.MAIN_VIEW)


func _start_game():
	(core as MM_GameState).call_transition(GameConstants.GAME_STATES.INGAME)


func _quit_game():
	get_tree().quit()
