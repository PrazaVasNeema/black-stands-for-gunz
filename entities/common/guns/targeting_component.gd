class_name TargetingComponent
extends Node

@export_range(0.0, 10.0) var max_turning_speed : float = 1.0

var _gun_targeting : Vector3
var _gun_target_quat : Quaternion
var _tween : Tween

func update_targeting(new_targeting : Vector3, parent_node3d : Node3D):

	_gun_targeting = (new_targeting - parent_node3d.global_transform.origin).normalized()
	_gun_target_quat = Quaternion(Vector3.FORWARD, _gun_targeting)
	var cross_product : Vector3 = 	new_targeting.cross(parent_node3d.global_transform.origin).normalized()
	var first_quat : Quaternion = Quaternion(cross_product, -_gun_target_quat.angle_to(parent_node3d.quaternion) * 0.90)
	first_quat = (first_quat * parent_node3d.quaternion).normalized()
	if (_tween):
		_tween.stop()
	_tween = get_tree().create_tween()
	var required_time : float = _gun_target_quat.angle_to(parent_node3d.quaternion) / max_turning_speed
	_tween.tween_property(parent_node3d, "quaternion", _gun_target_quat, required_time)


func _update_tween_activity(flag : bool):
	if !_tween:
		return
	
	if flag:
		if _tween.is_running():
			_tween.play()
	else:
		_tween.pause()
