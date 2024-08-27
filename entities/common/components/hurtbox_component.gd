class_name HurtboxComponent
extends Area3D


func _init() -> void:
	monitorable = false


func _ready() -> void:
	area_entered.connect(_on_area_entered)


## For handling hitboxes
func _on_area_entered(hitbox) -> void:
	print("HIT")
	if owner.has_method("take_damage"):
		owner.take_damage(hitbox.damage)


## For direct input from raycasts
func deal_damage(value : float):
	print(str(value))
