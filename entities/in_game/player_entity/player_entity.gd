class_name PlayerEntity
extends Node

@export var attack_component : AttackComponent


func init() -> void:
	attack_component.init()


func enable() -> void:
	G_InputService.roll_just_pressed.connect(attack_component.roll_drum)


func disable() -> void:
	G_InputService.roll_just_pressed.disconnect(attack_component.roll_drum)
