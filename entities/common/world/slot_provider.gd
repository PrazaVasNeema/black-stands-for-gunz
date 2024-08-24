class_name SlotProvider
extends Node3D

var gun_entity : GunEntity :
	set(value):
		gun_entity = value
		if gun_entity is GunEntity:
			if gun_entity.get_parent():
				gun_entity.reparent(self)
			else:
				add_child(gun_entity)
			gun_entity.position = Vector3.ZERO


func clear_gun_entity():
	if gun_entity:
		gun_entity.queue_free()
