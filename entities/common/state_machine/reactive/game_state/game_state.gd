class_name GameState
extends Node

signal transitioned(new_state_name : GameConstants.GAME_STATES)

@export var state_type : GameConstants.GAME_STATES
@export var sub_game_state_machine : SubGameStateMachine
@export var ui_root : Control

var core : Game


func init() -> void :
	ui_root.visible = false
	sub_game_state_machine.init(self)
	core.test()


func enter():
	ui_root.visible = true


func exit():
	ui_root.visible = false


func call_transition(new_state_name : GameConstants.GAME_STATES):
	transitioned.emit(new_state_name)
