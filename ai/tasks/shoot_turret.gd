@tool
extends BTAction


func _tick(delta: float) -> Status:
	var e_gun : EGun = blackboard.get_var(GameConstants.E_GUN)
	e_gun.should_fire = true
	return RUNNING
