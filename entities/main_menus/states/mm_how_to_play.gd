extends SubGameState

@export var back_button : UI_SubGameTransitionButton


func _ready() -> void:
	back_button.change_state.connect(call_transition)


func enter() -> void:
	super()
	G_CamerasManager.set_current(GameConstants.CAMERAS.HOW_TO_PLAY_VIEW)
