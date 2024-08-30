@tool
extends BTAction
## Stores the first node in the [member group] on the blackboard, returning [code]SUCCESS[/code]. [br]
## Returns [code]FAILURE[/code] if the group contains 0 nodes.

## Name of the SceneTree group.
@export var group: StringName

## Blackboard variable in which the task will store the acquired node.
@export var output_var: StringName = &"target"


func _generate_name() -> String:
	return "GetFirstNodeInGroup \"%s\"  ➜%s" % [
		group,
		LimboUtility.decorate_var(output_var)
		]

func _tick(_delta: float) -> Status:
	# print("testing")
	
	var e_gun : EGun = blackboard.get_var(GameConstants.E_GUN)
	e_gun.should_fire = false
	blackboard.set_var(GameConstants.ONLY_STARTS_ROTATING, true)
	var nodes: Array[Node] = agent.get_tree().get_nodes_in_group(group)
	if nodes.size() == 0:
		return FAILURE
	blackboard.set_var(output_var, nodes[0])
	return SUCCESS