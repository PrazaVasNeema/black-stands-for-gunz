class_name GunzMatrix
extends Node3D


@export var player_camera : Camera3D
@export var matrix_canvas : CanvasLayer
@export var main_crosshair : Sprite2D
@export var default_wall : Area3D
@export var boundaries_rate_vector2 : Vector2 = Vector2(0.9, 0.9)

var _final_boundaries : Vector4

@onready var _input_shogun : InputShogun = %InputShogun

func _ready() -> void:
	assert(_input_shogun, "!")
	_input_shogun.mouse_position_changed.connect(deal_with_mouse)
	var window_size = DisplayServer.window_get_size()
	main_crosshair.position = window_size / 2
	_final_boundaries = Vector4(window_size.x * (1 - boundaries_rate_vector2.x), window_size.x * boundaries_rate_vector2.x,
								window_size.y * (1 - boundaries_rate_vector2.y), window_size.y * boundaries_rate_vector2.y)
	#print ("screen size: " + str(window_size))
	#print ("final_boundaries: " + str(_final_boundaries))

	
func deal_with_mouse(relative : Vector2):
	var new_position = main_crosshair.position + relative
	#print(new_position)
	new_position.x = clamp(new_position.x, _final_boundaries.x, _final_boundaries.y)
	new_position.y = clamp(new_position.y, _final_boundaries.z, _final_boundaries.w)
	main_crosshair.position = new_position
