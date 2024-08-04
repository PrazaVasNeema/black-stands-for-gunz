class_name GunzShogun
extends Node


@export var gunz_slots_root : Node3D
@export_range(0.0, 90.0) var max_horizontal_rotation : float = 60.0
@export_range(0.0, 90.0) var max_vertical_rotation : float = 30.0
@export_range(0.0, 10.0) var max_turning_speed : float = 1.0

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
	


func update_targeting(target_ws_position : Vector3):
	#print(target_ws_position)
	_current_target = target_ws_position
	(_gunz_sets_array[active_set] as GunzSetData).gun_one.update_targeting(_current_target)
	(_gunz_sets_array[active_set] as GunzSetData).gun_two.update_targeting(_current_target)
