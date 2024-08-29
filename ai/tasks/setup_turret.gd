@tool
extends BTAction

@export var gun_root_bb : StringName = &"gun_root"
@export var handle_root_bb : StringName = &"handle_root" 

@export var gun_root : BBNode
@export var handle_root : BBNode




func _tick(delta: float) -> Status:
	if is_instance_valid(gun_root) && is_instance_valid(handle_root):
		blackboard.set_var(gun_root_bb, gun_root.get_value(scene_root, blackboard))
		blackboard.set_var(handle_root_bb, gun_root.get_value(scene_root, blackboard))
		return SUCCESS
	else:
		return FAILURE
