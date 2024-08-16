class_name GameplayPlayerShogun
extends Node


@export var _gunz_matrix_kanri : GunzMatrixKanri
@export var _gunz_kanri : GunzKanri


func lock_n_load(player_teikyou : PlayerTeikyou):
	_gunz_matrix_kanri.lock_n_load(player_teikyou.player_main_camera)
	_gunz_matrix_kanri.ws_aim_changed.connect(_on_ws_main_position_changed)
	_gunz_kanri.lock_n_load(player_teikyou.gunz_slots_array, _gunz_matrix_kanri.update_sub_crosshair)
	_gunz_kanri.loaded_old_position.connect(_gunz_matrix_kanri.just_plainly_set_position)
	G_InputService.choose_set_pressed.connect(_on_change_current_set)
	G_InputService.fire_just_pressed.connect(_on_fire_pressed)
	G_InputService.fire_just_released.connect(_on_fire_released)


func _on_ws_main_position_changed(ws_position : Vector3):
	_gunz_kanri.update_targeting(ws_position)


func _on_change_current_set(set_ind : int):
	_gunz_kanri.set_current_set(set_ind)


func _on_fire_pressed(gun_ind : int):
	_gunz_kanri.fire_start(gun_ind)


func _on_fire_released(gun_ind : int):
	_gunz_kanri.fire_stop(gun_ind)

