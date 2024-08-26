class_name SlotProvider
extends Node3D

var gun_entity : GunEntity :
	set(value):
		gun_entity = value
		if gun_entity is GunEntity:
			if gun_entity.get_parent():
				gun_entity.reparent(self, false)
				#gun_entity.p
			else:
				add_child(gun_entity)
			#gun_entity.position = Vector3.ZERO
			#gun_entity.position += Vector3(0, 0, -2)


func clear_gun_entity():
	if gun_entity:
		gun_entity.queue_free()


func set_ready_drum_wise(flag : bool):
	if !gun_entity:
		return
	
	if flag:
		gun_entity.conditions |= GameConstants.GUN_CHECKS.DRUM_WISE
	else:
		gun_entity.deinit()
	
