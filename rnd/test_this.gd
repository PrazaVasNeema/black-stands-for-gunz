@tool
extends Node3D

@onready var test : BatteryComponent = G_GameHelpers.get_child_of_type(self, BatteryComponent)

func _ready() -> void:
	print(test)
	print (find_children("", "BatteryComponent"))
	# G_GameHelpers.get_child_of_type("", self)


func _get_configuration_warnings():
	var warnings = []
	warnings.append("Requires BatteryComponent")
	if !G_GameHelpers.get_child_of_type(self, BatteryComponent):
		warnings.append("Requires BatteryComponent")
	
	return warnings