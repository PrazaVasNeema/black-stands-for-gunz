extends Node3D

@export var target : Node3D 
#@onready var target : Node3D = %Node3D2
@export var speed : float
var speed_rad : float :
	get:
		return deg_to_rad(speed)
#func _ready():
	#print(str(global_transform.basis.z))
	
	#print ("target position in local space: " + str(global_transform * target.global_position))

@export var stopwatch : float = 0

func _process(delta : float) -> void:
	var ls_pos = target.global_position * global_transform
	#print ("target position in local space: " + str(ls_pos))
	#print ("target ws pos: " + str(global_transform * ls_pos))
	
	var target_os = target.global_position * global_transform
	#target_os = Vector3(0, target_os.y, target_os.z)
	var target_ws_correct = global_transform * target_os
	var target_dir = (target_ws_correct - global_position).normalized()
	
	#print(str(target_ws_correct))
	
	var quat_v = Quaternion(Vector3.BACK, target_dir)
	
	quaternion = rotate_towards2(quaternion, quat_v, delta)


func rotate_towards(a: Quaternion, b: Quaternion, angle: float) -> Quaternion:
	var angle_to: float = a.angle_to(b)
	if angle_to > angle:
		return a.slerp(b, angle/angle_to)
	else:
		return b;


func rotate_towards2(a: Quaternion, b: Quaternion, delta: float) -> Quaternion:
	var angle_to: float = a.angle_to(b)
	var step = speed_rad * delta
	if angle_to > step:
		stopwatch += delta
		print(stopwatch)
		return a.slerp(b, step / angle_to)
	else:
		return b
