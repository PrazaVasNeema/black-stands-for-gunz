class_name LaserGun
extends EGun

@export var shoot_point : Marker3D
@export var lazer_depl_per_tick : float = 0.1
@export var time_between_ticks : float = 0.1
@export var damage_per_tick : float
@export var beam : LaserBeam


func _ready() -> void:
	super()
	#beam.transform = shoot_point.transform
	beam.tick_happened.connect(func() : 
		battery_component.cur_energy -= lazer_depl_per_tick
		)
	beam.change_damage_properties(time_between_ticks, damage_per_tick)
	should_fire = true
