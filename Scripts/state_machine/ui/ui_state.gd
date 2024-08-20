class_name UIState
extends Control

signal transitioned(new_state : GameConstants.UI_STATES)


@export var state_name : GameConstants.UI_STATES


func enter() -> void:
	self.visible = true


func exit() -> void:
	self.visible = false


func call_transition(new_state : GameConstants.UI_STATES):
	transitioned.emit(new_state)
