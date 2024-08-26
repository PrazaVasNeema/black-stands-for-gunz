class_name GunDrum
extends Node3D

signal changed_current(new_gun : GunEntity)

#@export var slot_pos_ref : Marker3D
@export var rotate_clockwise : bool
@export var slots_side : int = -1
@export var current_slot_index : int = 2

@export_range(0.1, 3) var drum_radius : float = 1.5
@export_range(0.1 , 2) var rotation_time : float
@export_range(30, 90) var rotation_angle : float

var slots_array : Array[SlotProvider]
var current_gun : GunEntity :
	get:
		return slots_array[current_slot_index].gun_entity
			

var _tweens_array : Array[Tween]
var _tween : Tween
var _rot_dir : float :
	get:
		return -1 if rotate_clockwise else 1
var _initial_quat : Quaternion


func _ready() -> void:
	_initial_quat = quaternion
	for i in range(5):
		var new_slot = SlotProvider.new()
		
		var angle = deg_to_rad((i - 2) * rotation_angle)
		var new_slot_position = Vector3(cos(angle) * slots_side * drum_radius, sin(angle) *\
		 -1.0 * slots_side * drum_radius, 0)
		new_slot.position = new_slot_position
		
		add_child(new_slot)
		
		#var visuals = MeshInstance3D.new()
		#visuals.mesh = BoxMesh.new()
		#new_slot.add_child(visuals)
		
		slots_array.append(new_slot)
		
		


func roll(new_gun : GunEntity):
	if _tween && _tween.is_running():
		_tween.pause()
		_tween.custom_step(rotation_time)
	slots_array[current_slot_index].set_ready_drum_wise(false)
	slots_array[slots_array.size() - 1].gun_entity = new_gun
	
	_tween = get_tree().create_tween()
	var final_rotation_angle = deg_to_rad(rotation_angle * _rot_dir)  # Convert 30 degrees to radians
	var rotation_quat = Quaternion(Vector3.FORWARD, final_rotation_angle)  # Create a quaternion for the X-axis rotation
	rotation_quat = Quaternion(global_transform.basis) * rotation_quat
	_tween.tween_property(self, "quaternion", rotation_quat, rotation_time).set_trans(Tween.TRANS_SPRING)
	_tween.tween_callback(_on_rotation_over.bind())


func _on_rotation_over():
	quaternion = _initial_quat
	print_debug("FINISHED")
	
	slots_array[0].clear_gun_entity()
	for i in range(0, slots_array.size() - 1, 1):
		slots_array[i].gun_entity = slots_array[i + 1].gun_entity
	
	if slots_array[current_slot_index + 1].gun_entity:
		print ("dfggg")
		slots_array[current_slot_index + 1].gun_entity.init()
	
	slots_array[current_slot_index].set_ready_drum_wise(true)
	if slots_array[current_slot_index].gun_entity:
		changed_current.emit(slots_array[current_slot_index].gun_entity)
