class_name LaserBeamBuhin
extends Node3D


const VisualizerScene = preload("res://scenes/_system/visualizer.tscn")

@export var beam_radius : float = 0.5
@export var ray_count : int = 10  # Number of rays across the beam's width
@export var ray_length : float = 100.0

var _space_state
var _visualizers_array : Array[Node3D]


func lock_n_load():
	_space_state = get_world_3d().direct_space_state
	for i in range(ray_count):
		var instance = G_ObjectPool.instantiate(VisualizerScene)
		add_child(instance)
		G_ObjectPool.return_instance(instance, VisualizerScene)



func calculate_beam():
	for i in range(ray_count):
		var offset_angle = (i / float(ray_count - 1)) * 2.0 - 1.0  # Normalized [-1, 1]
		var offset = beam_radius * offset_angle * Vector3(1, 0, 0)  # Offset in X direction

		var start_position = position + offset
		var end_position = position + Vector3(0, 0, 1) * ray_length

		var result = _space_state.intersect_ray(start_position, end_position)
		if result:
			var hit_position = result.position
			_draw_laser_segment(start_position, hit_position, i)
		else:
			_draw_laser_segment(start_position, end_position, i)


func _draw_laser_segment(start, end, index):
	_visualizers_array[index].position = end
