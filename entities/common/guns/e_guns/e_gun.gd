@tool
class_name EGun
extends Node3D

signal energy_depleted

@export var battery_component : BatteryComponent
var should_fire : bool


func init() -> void:
	pass

func _get_configuration_warnings():
	var warnings = []

	return warnings


