class_name GunKiso
extends Node3D


signal  cur_aim_position_changed(Vector3, int)


@export var set_configuration : SetConfigurationAsset

var gun_targeting : Vector3

var gun_target_quat : Quaternion
var is_rotating : bool = false

var _tween : Tween
var _this_gun_num : int


func lock_n_load(this_gun_num : int):
	_this_gun_num = this_gun_num

	var timer = Timer.new()
	timer.autostart = true
	timer.wait_time = 0.05
	add_child(timer)
	timer.timeout.connect(func():
		cur_aim_position_changed.emit(G_GameHelpers.get_raycast_results(global_position, quaternion), _this_gun_num)
	)


func update_targeting(new_targeting : Vector3):
	gun_targeting = (new_targeting - global_transform.origin).normalized()
	gun_target_quat = Quaternion(Vector3.FORWARD, gun_targeting)
	var cross_product : Vector3 = 	new_targeting.cross(global_transform.origin).normalized()
	var first_quat : Quaternion = Quaternion(cross_product, -gun_target_quat.angle_to(quaternion) * 0.90)
	first_quat = (first_quat * quaternion).normalized()
	if (_tween):
		_tween.stop()
	_tween = get_tree().create_tween()
	var required_time : float = gun_target_quat.angle_to(quaternion) / set_configuration.max_turning_speed
	_tween.tween_property(self, "quaternion", gun_target_quat, required_time)


# ATTACK ---


func fuc_em():
	pass

func prepare_the_fuc():
	pass
