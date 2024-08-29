@tool
extends BTAction

@export var should_be_more : bool
@export var angle_threshold: float
var _angle_threshold : float :
	get:
		return deg_to_rad(angle_threshold)
@export var target_var: StringName = &"target"
@export var gun_var: StringName = &"gun_root"


func _generate_name() -> String:
	return "Angle is %s than %d" % [("more" if should_be_more else "less"), angle_threshold]


func _tick(delta: float) -> Status:

	var target: Node3D = blackboard.get_var(target_var, null)
	var gun: Node3D = blackboard.get_var(gun_var, null)
	
	if not is_instance_valid(target) || not is_instance_valid(gun):
		
		return FAILURE

	var dir_to_target = (target.global_position - gun.global_position).normalized()
	
	var angle : float = acos(gun.global_transform.basis.z.dot(dir_to_target))
	#print(str(angle))

	if (angle > _angle_threshold if should_be_more else angle < _angle_threshold):
		return SUCCESS
	else:
		
		return FAILURE
