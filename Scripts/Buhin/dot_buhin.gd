extends Node


@export var _time_to_tick : float = 0.1
@export var _tick_damage : float = 10

var _health_to_affect_dir : Dictionary

func _add_target(target_health : HealthBuhin):
    if _health_to_affect_dir.has(target_health):
        return

    var tick_timer : SceneTreeTimer = get_tree().create_timer(_time_to_tick)
    tick_timer.timeout.connect(

    target_health.died.connect(_tick)
    tick_timer.timeout



func _tick(health_buhin : HealthBuhin):
    health_buhin._deal_damage(_tick_damage)


func _remove_target(target_health : HealthBuhin):
    if _health_to_affect_dir.has(target_health):
        return
    
    target_health.died.disconnect(_tick)
    _health_to_affect_dir.erase(target_health)