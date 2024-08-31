class_name EGun
extends Node3D

signal energy_depleted

@export var battery_component : BatteryComponent
var should_fire : bool

var can_n_should_fire : bool :
	get:
		return should_fire && battery_component.cur_energy > 0


func _ready() -> void:
	battery_component.depleted.connect(func() : energy_depleted.emit())
