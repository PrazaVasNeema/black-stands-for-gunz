extends Node

signal fire_just_pressed(gun_num : int)
signal fire_just_released(gun_num : int)
signal roll_just_pressed(drum_num : int)
signal use_slot_just_pressed(drum_num : int)
signal mouse_position_changed(relative : Vector2)
signal pause_pressed

@export_range(0, 10) var mouse_sensitivity : float = 1

func _init() -> void:
	# Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pass

# TODO: Consider using `event` instead if `Input`

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

	if (Input.is_action_just_pressed("roll_drum_one")):
		roll_just_pressed.emit(0)

	if (Input.is_action_just_pressed("roll_drum_two")):
		roll_just_pressed.emit(1)


func show_mouse(flag : bool):
	if flag:
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	else:
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
