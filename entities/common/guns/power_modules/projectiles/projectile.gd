class_name Projectile
extends Node3D

@export var speed : float = 10.0
@export var lifetime : float = 10.0

@export var lifetime_timer : Timer
@export var hitbox : HitboxComponent
@export var impact_detector : Area3D

var fly_dir : Vector3 = Vector3.ZERO




func _ready():
	lifetime_timer.timeout.connect(_on_impact.bind("haha"))
	lifetime_timer.start(lifetime)
	impact_detector.body_entered.connect(_on_impact)
	impact_detector.area_entered.connect(_on_impact)


func _physics_process(delta: float) -> void:
	position += fly_dir * speed * delta


func _on_impact(collision):
	queue_free()
