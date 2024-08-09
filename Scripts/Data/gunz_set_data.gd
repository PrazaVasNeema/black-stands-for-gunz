class_name GunzSetData
extends RefCounted


var gun_one : GunKiso
var gun_two : GunKiso
var set_target_position : Vector3 

func _init(gun_one : GunKiso, gun_two : GunKiso, set_target_position : Vector3) -> void:
	self.gun_one = gun_one
	self.gun_two = gun_two
	self.set_target_position = set_target_position
