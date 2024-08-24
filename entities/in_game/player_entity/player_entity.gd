class_name PlayerEntity
extends Node

@export var _matrix_component : MatrixComponent
@export var attack_component : AttackComponent


func init() -> void:
	attack_component.init()
	_matrix_component.init()


func enable() -> void:
	_matrix_component.matrix_canvas.visible = true
	G_InputService.roll_just_pressed.connect(attack_component.roll_drum)
	G_InputService.mouse_position_changed.connect(_matrix_component.deal_with_mouse)
	_matrix_component.ws_aim_changed.connect(attack_component.update_targeting)


func disable() -> void:
	_matrix_component.matrix_canvas.visible = false
	G_InputService.roll_just_pressed.disconnect(attack_component.roll_drum)
	G_InputService.mouse_position_changed.disconnect(_matrix_component.deal_with_mouse)
	_matrix_component.ws_aim_changed.disconnect(attack_component.update_targeting)
