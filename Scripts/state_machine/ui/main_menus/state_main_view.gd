extends UIState


@export var start_button : BaseButton
@export var options_button : UIChangeStateButton
@export var quit_button : BaseButton
@export var armory_button : UIChangeStateButton


func _ready() -> void:
	options_button.change_state.connect(call_transition)
	armory_button.change_state.connect(call_transition)
	quit_button.pressed.connect(_quit_game)


func _quit_game():
	get_tree().quit()
