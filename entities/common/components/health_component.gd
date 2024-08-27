class_name HealthComponent
extends Node

signal died

@export var max_health : float = 100.0

var current_health : float :
	set(value):
		current_health = clamp(value, 0.0, max_health)
		if current_health == 0.0:
			died.emit()

var invincible_flag : bool


func take_damage(damage : float) :
	if !invincible_flag:
		current_health -= damage


func take_heal(heal : float):
	current_health += heal
