extends UIState


@export var start_button : BaseButton
@export var options_button : UIChangeStateButton
@export var quit_button : BaseButton
@export var armory_button : UIChangeStateButton


func _ready() -> void:
	options_button.change_state.connect(call_transition)
	armory_button.change_state.connect(call_transition)
	start_button.pressed.connect(_start_game)
	quit_button.pressed.connect(_quit_game)


func enter() -> void:
	super()
	G_CamerasManager.set_current(GameConstants.CAMERAS.MAIN_VIEW)


func _start_game():
	_g_game_state_controller.i_want_to_change.emit(_g_game_state_controller)

func _quit_game():
	get_tree().quit()
