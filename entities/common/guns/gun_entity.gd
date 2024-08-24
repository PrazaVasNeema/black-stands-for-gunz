class_name GunEntity
extends Node3D

const ALL_CONDITIONS_MASK = 0b111

@export var targeting_component : TargetingComponent

var conditions = 0b110 :
	set(value):
		print(str(conditions))
		conditions = value
		print(str(conditions))
		print("bbb" + str(is_ready))
		targeting_component._update_tween_activity(is_ready)

var is_ready : bool :
	get:
		print("aaa" + str(conditions))
		print("ccc" + str(conditions & ALL_CONDITIONS_MASK))
		return (conditions & ALL_CONDITIONS_MASK) == ALL_CONDITIONS_MASK


func update_targeting(new_ws_position : Vector3):
	if is_ready:
		targeting_component.update_targeting(new_ws_position, self)
