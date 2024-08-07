class_name GunSlotData
extends RefCounted


var slot_node_ref : Node3D
var gun : GunKiso


func _init(slot_node_ref : Node3D, gun : GunKiso) -> void:
	self.slot_node_ref = slot_node_ref
	self.gun = gun
