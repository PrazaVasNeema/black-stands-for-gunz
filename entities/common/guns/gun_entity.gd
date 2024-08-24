class_name GunEntity
extends Node3D

@export_range(0.0, 10.0) var max_turning_speed : float = 1.0
@export var targeting_component : TargetingComponent

var ready_drum_wise : bool :
	set(value):
		_update_tween_activity()
		ready_drum_wise = value
var ready_game_wise : bool :
	set(value):
		_update_tween_activity()
		ready_game_wise = value
var ready_gun_wise : bool :
	set(value):
		_update_tween_activity()
		ready_game_wise = value

var ready_collective : bool :
	get:
		return ready_drum_wise && ready_game_wise && ready_gun_wise

var _gun_targeting : Vector3
var _gun_target_quat : Quaternion
var _tween : Tween



func update_targeting(new_targeting : Vector3):
	if !ready_drum_wise:
		return
	_gun_targeting = (new_targeting - global_transform.origin).normalized()
	_gun_target_quat = Quaternion(Vector3.FORWARD, _gun_targeting)
	var cross_product : Vector3 = 	new_targeting.cross(global_transform.origin).normalized()
	var first_quat : Quaternion = Quaternion(cross_product, -_gun_target_quat.angle_to(quaternion) * 0.90)
	first_quat = (first_quat * quaternion).normalized()
	if (_tween):
		_tween.stop()
	_tween = get_tree().create_tween()
	var required_time : float = _gun_target_quat.angle_to(quaternion) / max_turning_speed
	_tween.tween_property(self, "quaternion", _gun_target_quat, required_time)


func _update_tween_activity():
	if ready_drum_wise:
		_tween.play()
	else:
		_tween.pause()
