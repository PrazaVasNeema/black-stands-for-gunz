class_name GunzKanri
extends Node


#signal targets_position_changed(Vector4)
signal loaded_old_position(Vector3)


var active_set : int

var _current_target : Vector3
var _gunz_sets_array : Array[GunzSetData]
var _matrix_change_sub_c_callable : Callable


func lock_n_load(gun_slots_array : Array[GunSlotData], matrix_callable : Callable) -> void:
	
	var i = 0
	while i < gun_slots_array.size():
		_gunz_sets_array.append(GunzSetData.new(gun_slots_array[i].gun, gun_slots_array[i + 1].gun, Vector3.ZERO))
		i += 2
	active_set = 0
	_matrix_change_sub_c_callable = matrix_callable


func update_targeting(target_ws_position : Vector3):
	_current_target = target_ws_position
	(_gunz_sets_array[active_set] as GunzSetData).gun_one.update_targeting(_current_target)
	(_gunz_sets_array[active_set] as GunzSetData).gun_two.update_targeting(_current_target)
	(_gunz_sets_array[active_set] as GunzSetData).set_target_position = _current_target


func set_current_set(set_ind : int):
	_gunz_sets_array[active_set].set_target_position = _current_target

	if _gunz_sets_array[active_set].gun_one.cur_aim_position_changed.is_connected(_matrix_change_sub_c_callable):
		_gunz_sets_array[active_set].gun_one.cur_aim_position_changed.disconnect(_matrix_change_sub_c_callable)
		_gunz_sets_array[active_set].gun_two.cur_aim_position_changed.disconnect(_matrix_change_sub_c_callable)

	active_set = set_ind - 1
	_current_target = _gunz_sets_array[active_set].set_target_position

	if _current_target!= Vector3.ZERO:
		print("testing")
		loaded_old_position.emit(_current_target)
	
	_gunz_sets_array[active_set].gun_one.cur_aim_position_changed.connect(_matrix_change_sub_c_callable)
	_gunz_sets_array[active_set].gun_two.cur_aim_position_changed.connect(_matrix_change_sub_c_callable)


func get_current_set() -> GunzSetData:
	return (_gunz_sets_array[active_set] as GunzSetData)


func fire_start(gun_ind : int):
	match gun_ind:
		0:
			_gunz_sets_array[active_set].gun_one.fuc_em_start()
		1:
			_gunz_sets_array[active_set].gun_two.fuc_em_start()


func fire_stop(gun_ind : int):
	match gun_ind:
		0:
			_gunz_sets_array[active_set].gun_one.fuc_em_stop()
		1:
			_gunz_sets_array[active_set].gun_two.fuc_em_stop()

