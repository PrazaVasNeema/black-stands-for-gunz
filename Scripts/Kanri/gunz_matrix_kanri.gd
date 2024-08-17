class_name GunzMatrixKanri
extends Node3D

## Don't forget to lock_n_load!


signal ws_aim_changed(ws_position : Vector3)


@export var boundaries_rate_vector2 : Vector2 = Vector2(0.9, 0.9)
@export var _sub_crosshairs : Array[Sprite2D]

var _final_boundaries : Vector4
var _player_camera : Camera3D

@onready var _matrix_canvas : CanvasLayer = $MatrixCanvas
@onready var _main_crosshair : Sprite2D = $MatrixCanvas/MainCrosshair
@onready var _ws_phantom_main_c : Node3D = $WSPhantomMainC


func lock_n_load(player_camera : Camera3D):
	_player_camera = player_camera
	var window_size = DisplayServer.window_get_size()
	_main_crosshair.position = window_size / 2
	_final_boundaries = Vector4(window_size.x * (1 - boundaries_rate_vector2.x), window_size.x * boundaries_rate_vector2.x, 
	window_size.y * (1 - boundaries_rate_vector2.y), window_size.y * boundaries_rate_vector2.y)
	G_InputService.mouse_position_changed.connect(deal_with_mouse)


func deal_with_mouse(relative : Vector2):
	var new_position = _main_crosshair.position + relative
	new_position.x = clamp(new_position.x, _final_boundaries.x, _final_boundaries.y)
	new_position.y = clamp(new_position.y, _final_boundaries.z, _final_boundaries.w)
	_main_crosshair.position = new_position
	ws_aim_changed.emit(G_GameHelpers.get_ws_position_from_mouse(_player_camera, new_position))
	_ws_phantom_main_c.position = G_GameHelpers.get_ws_position_from_mouse(_player_camera, new_position)


func just_plainly_set_position(new_position_ws : Vector3):
	print("testing2")
	_main_crosshair.position = _player_camera.unproject_position(new_position_ws)


func update_sub_crosshair(new_position_ws : Vector3, crosshair_num : int):
	_sub_crosshairs[crosshair_num].position = _player_camera.unproject_position(new_position_ws)
