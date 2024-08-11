class_name GunKiso
extends Node3D


@export var set_configuration : SetConfigurationAsset

var gun_targeting : Vector3

var gun_target_quat : Quaternion
var is_rotating : bool = false

var _tween : Tween


func update_targeting(new_targeting : Vector3):
	gun_targeting = (new_targeting - global_transform.origin).normalized()
	gun_target_quat = Quaternion(Vector3.FORWARD, gun_targeting)
	var cross_product : Vector3 = 	new_targeting.cross(global_transform.origin).normalized()
	var first_quat : Quaternion = Quaternion(cross_product, -gun_target_quat.angle_to(quaternion) * 0.90)
	first_quat = (first_quat * quaternion).normalized()
	if (_tween):
		_tween.stop()
	_tween = get_tree().create_tween()
	var required_time : float = gun_target_quat.angle_to(quaternion) / 1
	_tween.tween_property(self, "quaternion", gun_target_quat, required_time)
