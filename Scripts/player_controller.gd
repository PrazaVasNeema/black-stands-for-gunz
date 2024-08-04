class_name PlayerController
extends Node


@onready var _gunz_shogun : GunzShogun = $GunzShogun
@onready var _gunz_matrix : GunzMatrix = $GunzMatrix
@onready var _player_main_camera : Camera3D = $PlayerMainCamera
@onready var _input_shogun : InputShogun = %InputShogun


func _ready() -> void:
	_gunz_matrix.lock_n_load(_player_main_camera, _input_shogun)
	#gunz_shogun.lock_n_load()
	#_input_shogun.mouse_position_changed.connect(deal_with_mouse)
	
	_gunz_matrix.ws_aim_changed.connect(_on_ws_main_position_changed)


func _on_ws_main_position_changed(ws_position : Vector3):
	print(ws_position)
