class_name AttackComponent
extends Node

var gun_drums_array : Array[GunDrum]


func init() -> void:
	gun_drums_array = G_ArmoryManager.gun_drums_array


func roll_drum(drum_num : int):
	for i in range(gun_drums_array.size()):
		G_ArmoryManager.load_random_gun(drum_num)


func update_targeting(target_ws_position : Vector3):
	for drum in gun_drums_array:
		if drum.slots_array[drum.current_slot_index].gun_entity:
			drum.slots_array[drum.current_slot_index].gun_entity.update_targeting(target_ws_position)
