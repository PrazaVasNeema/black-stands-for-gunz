class_name GunzShogun
extends Node


@export var gunz_slots_root : Node3D


var active_set : int

var _sets_dictionary : Dictionary
var _current_target : Vector3
var _gunz_sets_array : Array


func lock_n_load() -> void:
	var all_gunz_slots : Array = gunz_slots_root.get_children()
	var i = 0
	while i < all_gunz_slots.size():
		_gunz_sets_array.append(GunzSetData.new((all_gunz_slots[i] as Node3D).get_child(0) as GunKiso,
		(all_gunz_slots[i+1] as Node3D).get_child(0) as GunKiso,
		Vector3.ZERO))
		i += 2
	active_set = 0
	for gunz_set in _gunz_sets_array:
		print_debug((gunz_set as GunzSetData).gun_one)
		print_debug((gunz_set as GunzSetData).gun_two)
	#print_debug(_gunz_sets_array)
	


func update_targeting(target_ws_position : Vector3):
	#print(target_ws_position)
	_current_target = target_ws_position
	(_gunz_sets_array[active_set] as GunzSetData).gun_one.update_targeting(_current_target)
	(_gunz_sets_array[active_set] as GunzSetData).gun_two.update_targeting(_current_target)
	(_gunz_sets_array[active_set] as GunzSetData).set_target_position = _current_target


func set_current_set(set_ind : int):
	active_set = set_ind - 1


func get_current_set() -> GunzSetData:
	return (_gunz_sets_array[active_set] as GunzSetData)
