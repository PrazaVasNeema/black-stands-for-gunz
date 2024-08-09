class_name GameplayPlayerShogun
extends Node


@export var _gunz_matrix_kanri : GunzMatrixKanri
@export var _gunz_kanri : GunzKanri


func lock_n_load(player_teikyou : PlayerTeikyou, input_service : InputService):
	_gunz_matrix_kanri.lock_n_load(player_teikyou.player_main_camera, input_service)
	_gunz_matrix_kanri.ws_aim_changed.connect(_on_ws_main_position_changed)
	_gunz_kanri.lock_n_load(player_teikyou.gunz_slots_array)
	input_service.choose_set_pressed.connect(_on_change_current_set)


func _on_ws_main_position_changed(ws_position : Vector3):
	_gunz_kanri.update_targeting(ws_position)


func _on_change_current_set(set_ind : int):
	_gunz_kanri.set_current_set(set_ind)
