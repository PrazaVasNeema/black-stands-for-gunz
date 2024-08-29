extends BTAction

@export var rotation_speed : float = 10
var rot_speed_rad : float :
	get:
		return deg_to_rad(rotation_speed)

var duration : float

var lerp_factor : float
var start_quat : Quaternion
var end_quat : Quaternion
var should_rotate_v : bool

func _tick(delta: float) -> Status:
	var quat_h : Quaternion = blackboard.get_var(GameConstants.TARGET_QUAT_H)
	var quat_v : Quaternion = blackboard.get_var(GameConstants.TARGET_QUAT_V)
	var handle : Node3D = blackboard.get_var(GameConstants.HANDLE_ROOT)
	var gun : Node3D = blackboard.get_var(GameConstants.GUN_ROOT)
	
	var global_quat_handle = handle.global_transform.basis.get_rotation_quaternion()
	var global_quat_gun = gun.global_transform.basis.get_rotation_quaternion()
	
	var should_rotate_h = blackboard.get_var(GameConstants.ONLY_STARTS_ROTATING)
	
	if quat_h.angle_to(global_quat_handle) > 0.1 && should_rotate_h:
		handle.global_transform.basis = Basis(G_GameHelpers.rotate_quat_towards(handle.global_transform.basis.get_rotation_quaternion(),\
		quat_h, rot_speed_rad, delta))
	elif quat_v.angle_to(global_quat_gun) > 0.1:
		blackboard.set_var(GameConstants.ONLY_STARTS_ROTATING, false)
		gun.global_transform.basis = Basis(G_GameHelpers.rotate_quat_towards(gun.global_transform.basis.get_rotation_quaternion(),\
		quat_v, rot_speed_rad, delta))
	else:
		return SUCCESS
	return RUNNING
	


func rotate(delta : float, target_quat : Quaternion, node3d : Node3D) -> bool:
	
	if lerp_factor < 1.0:
		lerp_factor += delta / duration
		
		node3d.quaternion = start_quat.slerp(end_quat, lerp_factor)
		return true
	else:
		return false


func are_quaternions_close(q1: Quaternion, q2: Quaternion, threshold: float = 0.01) -> bool:
	var dot_product = q1.dot(q2)
	return abs(dot_product) > (1.0 - threshold)


func angle_between_quats(q1: Quaternion, q2: Quaternion):
	var dot_product = q1.dot(q2)
	return acos(dot_product)
