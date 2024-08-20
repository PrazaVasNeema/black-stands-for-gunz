extends UIState


@export var back_button : UIChangeStateButton


func _ready() -> void:
	back_button.change_state.connect(call_transition)


func enter() -> void:
	super()
	G_CamerasManager.set_current(GameConstants.CAMERAS.OPTIONS_VIEW)
