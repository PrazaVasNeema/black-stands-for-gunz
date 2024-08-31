class_name BatteryComponent
extends Node

signal depleted

@export var max_energy : float = 100

var cur_energy : float :
	set(value):
		cur_energy = clamp(value, 0, max_energy)
		if cur_energy == 0:
			depleted.emit()
		print(str(cur_energy))



func _ready() -> void:
	cur_energy = max_energy
