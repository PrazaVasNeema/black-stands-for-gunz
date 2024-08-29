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
	
	
	
	if blackboard.get_var(GameConstants.ONLY_STARTS_ROTATING):
		
		
		duration = angle_between_quats(handle.quaternion, quat_h) / rot_speed_rad
		lerp_factor = 0
		start_quat = handle.quaternion
		end_quat = quat_h
		blackboard.set_var(GameConstants.ONLY_STARTS_ROTATING, false)
		should_rotate_v = false
		
	
	
	if !should_rotate_v:
		if rotate(delta, quat_h, handle):
			duration = angle_between_quats(gun.quaternion, quat_v) / rot_speed_rad
			start_quat = gun.quaternion
			end_quat = quat_v
			should_rotate_v = true
			
	else:
		
		if rotate(delta, quat_v, gun):
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
