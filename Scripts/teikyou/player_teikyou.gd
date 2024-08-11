class_name PlayerTeikyou
extends Node3D


@export var _gunz_slots_root : Node3D
@export var _player_main_camera : Camera3D
var player_main_camera : Camera3D:
	get:
		return _player_main_camera


var gunz_slots_array : Array[GunSlotData]


func _ready() -> void:
	var all_gunz_slots : Array = _gunz_slots_root.get_children()
	for gun_slot in all_gunz_slots:
		gunz_slots_array.append(GunSlotData.new(gun_slot, null))


func equip_gun(gun_scene : PackedScene, slot_num : int):
	if gunz_slots_array[slot_num].gun:
		gunz_slots_array[slot_num].gun.queue_free()
	
	var gun_itself : GunKiso = gun_scene.instantiate() as GunKiso
	gun_itself.lock_n_load(slot_num % 2)
	gunz_slots_array[slot_num].slot_node_ref.add_child(gun_itself)
	gunz_slots_array[slot_num].gun = gun_itself



func reset_gunz():
	for gun_slot in gunz_slots_array:
		if gun_slot.gun == null:
			continue
		gun_slot.gun.rotation = Vector3.ZERO
