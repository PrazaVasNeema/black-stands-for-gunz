extends Node

signal fire_just_pressed(gun_num : int)
signal fire_just_released(gun_num : int)
signal reload_pressed
signal choose_set_pressed(set_num : int)
signal mouse_position_changed(relative : Vector2)
signal pause_pressed

@export_range(0, 10) var mouse_sensitivity : float = 1

func _init() -> void:
	# Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

func _input(event: InputEvent) -> void:
	if Input.is_action_just_pressed("pause"):
		pause_pressed.emit()

	if event is InputEventMouseMotion:
		mouse_position_changed.emit(event.relative * mouse_sensitivity)
	
	if (Input.is_action_just_pressed("fire_one")):
		fire_just_pressed.emit(0)
	if (Input.is_action_just_released("fire_one")):
		fire_just_released.emit(0)

	if (Input.is_action_just_pressed("fire_two")):
		fire_just_pressed.emit(1)
	if (Input.is_action_just_released("fire_two")):
		fire_just_released.emit(1)

	if (Input.is_action_just_pressed("reload")):
		reload_pressed.emit()
	
	var emit_choose_set_num : int = -1
	if (Input.is_action_just_pressed("set_1")):
		emit_choose_set_num = 1
	if (Input.is_action_just_pressed("set_2")):
		emit_choose_set_num = 2
	if (Input.is_action_just_pressed("set_3")):
		emit_choose_set_num = 3
	if (emit_choose_set_num != -1):
		choose_set_pressed.emit(emit_choose_set_num)
	
