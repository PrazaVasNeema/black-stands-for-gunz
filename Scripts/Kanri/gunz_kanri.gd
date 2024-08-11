class_name GunzKanri
extends Node


#signal targets_position_changed(Vector4)


var active_set : int

var _current_target : Vector3
var _gunz_sets_array : Array[GunzSetData]


func lock_n_load(gun_slots_array : Array[GunSlotData]) -> void:
	
	var i = 0
	while i < gun_slots_array.size():
		_gunz_sets_array.append(GunzSetData.new(gun_slots_array[i].gun, gun_slots_array[i + 1].gun, Vector3.ZERO))
		i += 2
	active_set = 0


func update_targeting(target_ws_position : Vector3):
	_current_target = target_ws_position
	(_gunz_sets_array[active_set] as GunzSetData).gun_one.update_targeting(_current_target)
	(_gunz_sets_array[active_set] as GunzSetData).gun_two.update_targeting(_current_target)
	(_gunz_sets_array[active_set] as GunzSetData).set_target_position = _current_target


func set_current_set(set_ind : int):
	active_set = set_ind - 1


func get_current_set() -> GunzSetData:
	return (_gunz_sets_array[active_set] as GunzSetData)
