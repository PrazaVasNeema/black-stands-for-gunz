class_name GunKiso
extends Node3D


@export var set_configuration : SetConfigurationAsset

var gun_targeting : Vector3


func update_targeting(new_targeting : Vector3):
	gun_targeting = new_targeting


func _process(delta: float) -> void:
	if gun_targeting:
		align_gun_with_targeting(delta)


func align_gun_with_targeting(delta : float):
	var target_vector = global_position.direction_to(gun_targeting)
	var target_basis= Basis.looking_at(target_vector)
	basis = basis.slerp(target_basis, 0.5 * set_configuration.max_turning_speed)
