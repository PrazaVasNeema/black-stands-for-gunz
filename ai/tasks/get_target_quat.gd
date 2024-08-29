@tool
extends BTAction


@export var target_quat_h : StringName = &"target_quat_h"
@export var target_quat_v : StringName = &"target_quat_v"

@export var target_var: StringName = &"target"
@export var handle_var: StringName = &"handle_root"
@export var gun_var: StringName = &"gun_root"


func _tick(delta: float) -> Status:
	var target = blackboard.get_var(target_var, null)
	var handle = blackboard.get_var(handle_var, null)
	var gun = blackboard.get_var(gun_var, null)
	
	var quat_h : Quaternion
	var quat_v : Quaternion
	
	# Horizontal
	var target_os : Vector3 = target.global_position * handle.global_transform
	#print("----")
	#print (str(handle.global_position))
	#print (str(target_os))
	target_os = Vector3(target_os.x, 0, target_os.z)
	var target_ws_correct : Vector3 = handle.global_transform * target_os
	#print (str(target_ws_correct))
	
	var target_dir : Vector3 = (target_ws_correct - handle.global_position).normalized()
	
	#print (str(target_dir))
	
	quat_h = Quaternion(Vector3.BACK, target_dir)
	
	#print_debug("dfgfggf" + str(quat_h))
	
	# Vertical
	target_os = target.global_position * gun.global_transform
	#target_os = Vector3(0, target_os.y, target_os.z)
	target_ws_correct = gun.global_transform * target_os
	print (str(target_ws_correct))
	target_dir = (target_ws_correct - gun.global_position).normalized()
	
	quat_v = Quaternion(Vector3.BACK, target_dir)
	
	blackboard.set_var(target_quat_h, quat_h)
	blackboard.set_var(target_quat_v, quat_v)
	
	return SUCCESS
	
