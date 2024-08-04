class_name GunKiso
extends Node3D


@export var set_configuration : SetConfigurationAsset

var gun_targeting : Vector3

var gun_target_quat : Quaternion
var is_rotating : bool = false



func update_targeting(new_targeting : Vector3):
	gun_targeting = (new_targeting - global_transform.origin).normalized()
	gun_target_quat = Quaternion(Vector3.FORWARD, gun_targeting)
	is_rotating = true


func _process(delta: float) -> void:
	if gun_targeting:
		align_gun_with_targeting(delta)




func align_gun_with_targeting(delta : float):
	if !is_rotating:
		return
	
	var current_quat : Quaternion = quaternion
	var interpolated_quat : Quaternion = current_quat.slerp(gun_target_quat, delta * set_configuration.max_turning_speed)
	
	if (interpolated_quat.angle_to(quaternion) < 0.0001):
		is_rotating = false
		interpolated_quat = gun_target_quat
	quaternion = interpolated_quat
	#
	#
	#var current_rotation = global_transform.basis.get_rotation_quaternion()
	#var target_rotation = Quaternion(global_transform.basis).slerp(Quaternion(Vector3(0, 0, -1), gun_targeting), delta * 30)
	#
	#var step = deg_to_rad(30) * delta
	#var new_rotation = current_rotation.slerp(target_rotation, step)
	#global_transform.basis = Basis(new_rotation)
	
