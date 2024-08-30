class_name HurtboxComponent
extends Area3D

signal got_damage(damage : float)

# func _init() -> void:
# 	monitorable = false


func _ready() -> void:
	area_entered.connect(_on_area_entered)


## For handling hitboxes
func _on_area_entered(hitbox : HitboxComponent) -> void:
	got_damage.emit(hitbox.damage)


## For direct input from raycasts
func deal_damage(value : float):
	got_damage.emit(value)
