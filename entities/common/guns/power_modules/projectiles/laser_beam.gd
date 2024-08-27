class_name LaserBeam
extends Node3D

@export_category("Physical properties")
@export var beam_radius : float = 0.5
@export var ray_length : float = 30.0
@export_flags_3d_physics var hit_layer_mask
@export var tick_timer : Timer


@export_category("Graphics properties")
@export var beam_cgs : MeshInstance3D
var _beam_mesh : CylinderMesh :
	get:
		return beam_cgs.mesh
	set(value):
		beam_cgs.mesh = _beam_mesh

var _tick_damage : float
var _visualizer : Node3D
var _beam_tween : Tween
var material_instance : BaseMaterial3D

func init():
	_visualizer = MeshInstance3D.new()
	_visualizer.mesh = SphereMesh.new()
	add_child(_visualizer)
	_beam_mesh.top_radius = beam_radius
	_beam_mesh.bottom_radius = beam_radius
	original_scale = beam_cgs.scale
	material_instance = _beam_mesh.material

var original_scale : Vector3
var target_scale : Vector3  # The scale you want to reach
var speed : float = 10  # How fast the interpolation should happen
var scaling_in_progress : bool

func _process(delta: float) -> void:
	if scaling_in_progress:
		if (beam_cgs.scale - target_scale).length_squared() >= 0.0001:
			beam_cgs.scale = beam_cgs.scale.lerp(target_scale, speed * delta)
		else:
			scaling_in_progress = false
			if tick_timer.is_stopped():
				beam_cgs.visible = false
	#_beam.visible = true
	#_beam_path.curve.set_point_position(1, -Vector3(0, 0, randf_range(1, 10)))
	if !tick_timer.is_stopped():
		var new_emission_energy = 8 + sin(Time.get_ticks_msec() * 0.003) * 2.0  # Example dynamic value
		material_instance.emission_energy_multiplier = new_emission_energy
	


func change_damage_properties(tick_time : float, tick_damage : float):
	tick_timer.wait_time = tick_time
	_tick_damage = tick_damage


func turn_on_beam():
	beam_cgs.visible = true
	tick_timer.timeout.connect(calculate_beam)
	tick_timer.start()
	target_scale = original_scale
	scaling_in_progress = true


func turn_off_beam():
	tick_timer.timeout.disconnect(calculate_beam)
	tick_timer.stop()
	target_scale = Vector3(0.00001, original_scale.y, 0.00001)
	scaling_in_progress = true


func calculate_beam():
	var s_g_position : Vector3 = to_global(position)
	var e_g_position : Vector3 = s_g_position + Quaternion(global_transform.basis) * quaternion * Vector3.FORWARD * ray_length
	#var e_g_position = Vector3(100, 0, 0)
	var results = G_GameHelpers.get_raycast_results(s_g_position, e_g_position, hit_layer_mask)
	#print(str(results))
	var length_2x : float
	if results.size():
		_visualizer.global_position = results.get("position")
		length_2x = (s_g_position - results.get("position")).length_squared()
	else:
		length_2x = (s_g_position - e_g_position).length_squared()
		_visualizer.global_position = e_g_position
	update_beam_visuals(sqrt(length_2x))


func update_beam_visuals(length : float):
	_beam_mesh.height = length
	beam_cgs.position = Vector3(0, 0, -length / 2)
