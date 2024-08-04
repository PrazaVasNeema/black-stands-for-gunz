class_name GunzShogun
extends Node


@export var gunz_slots_root : Node3D
@export_range(0.0, 90.0) var max_horizontal_rotation : float = 60.0
@export_range(0.0, 90.0) var max_vertical_rotation : float = 30.0
@export_range(0.0, 10.0) var max_turning_speed : float = 1.0

var active_set : int

var _sets_dictionary : Dictionary


func lock_n_load() -> void:
	var all_gunz : Array = gunz_slots_root.get_children()
	for i in range(0, all_gunz.size()):
		_sets_dictionary[Vector2((i + 1) / 2, (i + 1) % 2)] = (all_gunz[i] as Node3D).get_child(0) as GunKiso
	active_set = 0
