class_name UI_SubGameTransitionButton
extends Button

signal change_state(new_state : GameConstants.SUB_GAME_STATES)

@export var new_state : GameConstants.SUB_GAME_STATES


func _ready() -> void:
	pressed.connect(_on_button_pressed)


func _on_button_pressed():
	change_state.emit(new_state)
