class_name PowerModule
extends Node

signal module_changed_ready_status(new_status)

var battery_component_ref : BatteryComponent


func init(battery_component : BatteryComponent):
	battery_component_ref = battery_component
