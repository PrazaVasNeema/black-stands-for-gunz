extends Node3D


var _world_space : PhysicsDirectSpaceState3D
var _start : Vector3
var _end : Vector3
var result_raw : Dictionary
var result : Vector3
func get_ws_position_from_mouse(camera : Camera3D, mouse_position : Vector2) -> Vector3:
	_world_space = get_world_3d().direct_space_state
	_start = camera.project_ray_origin(mouse_position)
	_end = camera.project_position(mouse_position, 1000)
	result_raw = _world_space.intersect_ray(PhysicsRayQueryParameters3D.create(_start, _end))
	if result_raw.size() == 0:
		return _end
	else:
		return result_raw.get("position")