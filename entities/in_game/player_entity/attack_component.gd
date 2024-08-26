class_name AttackComponent
extends Node

var guns_array : Array[GunEntity]
var firing_state_array : Array[bool]

func init() -> void:
	guns_array = [null, null]
	firing_state_array = [false, false]
	for i in range(2):
		G_ArmoryManager.gun_drums_array[i].changed_current.connect(update_gun_ref.bind(i))


func deinit() -> void:
	for i in range(2):
		G_ArmoryManager.gun_drums_array[i].changed_current.disconnect(update_gun_ref.bind(i))


func roll_drum(drum_num : int):
	#for i in range(gun_drums_array.size()):
	G_ArmoryManager.load_random_gun(drum_num)


func update_targeting(target_ws_position : Vector3):
	for gun in guns_array:
		if gun:
			gun.update_targeting(target_ws_position)


func update_gun_ref(new_gun_entity : GunEntity, drum_num : int):
	if guns_array[drum_num]:
		guns_array[drum_num].gun_finished.disconnect(roll_drum.bind(drum_num))
	
	guns_array[drum_num] = new_gun_entity
	guns_array[drum_num].gun_finished.connect(roll_drum.bind(drum_num))
	update_gun_firing_condition(drum_num, firing_state_array[drum_num])


func set_firing_state(gun_ind : int, state : bool):
	firing_state_array[gun_ind] = state
	update_gun_firing_condition(gun_ind, state)


func update_gun_firing_condition(gun_ind : int, state : bool):
	print(str(gun_ind) + " " + str(state))
	if guns_array[gun_ind]:
		guns_array[gun_ind].set_should_fire(state)
		
