class_name GunKiso
extends Node3D


@export var set_configuration : SetConfigurationAsset

var gun_targeting : Vector3

var gun_target_quat : Quaternion
var is_rotating : bool = false

var _tween : Tween


#func _ready() -> void:
	

@export var palka1 : Node3D
@export var palka2 : Node3D


func update_targeting(new_targeting : Vector3):
	gun_targeting = (new_targeting - global_transform.origin).normalized()
	
	gun_target_quat = Quaternion(Vector3.FORWARD, gun_targeting)
	
	#palka2.quaternion = gun_target_quat
	
	var cross_product : Vector3 = 	new_targeting.cross(global_transform.origin).normalized()
	var first_quat : Quaternion = Quaternion(cross_product, -gun_target_quat.angle_to(quaternion) * 0.90)
	first_quat = (first_quat * quaternion).normalized()
	
	#palka1.quaternion = first_quat
	
	#is_rotating = true
	
	#print(first_quat)
	
	#print(_tween.is_running())
	
	#print(gun_target_quat.angle_to(quaternion))
	
	if (_tween):
		_tween.stop()
	_tween = get_tree().create_tween()
	var required_time : float = gun_target_quat.angle_to(quaternion) / 1
	_tween.tween_property(self, "quaternion", gun_target_quat, required_time)
	
	#_tween.tween_property(self, "quaternion", gun_target_quat, required_time).set_trans(Tween.TRANS_BOUNCE)
	#_tween.tween_property(self, "quaternion", gun_target_quat, required_time)
	
	
	#_tween.tween_property(self, "quaternion", first_quat, required_time)
	#_tween.chain().tween_property(self, "quaternion", gun_target_quat, 0.2).set_trans(Tween.TRANS_BOUNCE)
	
	
	#_tween.chain().tween_property(self, "quaternion", first_quat, required_time).tween_property(self, "quaternion", gun_target_quat, required_time).set_trans(Tween.TRANS_BOUNCE)
	
	#_tween.play()


func _process(delta: float) -> void:
	if gun_targeting:
		return
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
	
