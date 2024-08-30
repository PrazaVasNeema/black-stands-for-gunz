@tool
extends BTAction

@export var gun_root_bb : StringName = &"gun_root"
@export var handle_root_bb : StringName = &"handle_root" 
@export var e_gun_bb : StringName = &"e_gun" 

@export var gun_root : BBNode
@export var handle_root : BBNode
@export var e_gun : BBNode


func _tick(delta: float) -> Status:
	if is_instance_valid(gun_root) && is_instance_valid(handle_root) && is_instance_valid(e_gun):
		blackboard.set_var(gun_root_bb, gun_root.get_value(scene_root, blackboard))
		blackboard.set_var(handle_root_bb, gun_root.get_value(scene_root, blackboard))
		blackboard.set_var(e_gun_bb, e_gun.get_value(scene_root, blackboard))
		return SUCCESS
	else:
		return FAILURE
