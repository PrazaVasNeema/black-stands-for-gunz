class_name HealthBuhin
extends Node


signal died


@export var _max_health : float = 10

var _cur_health : float :
    set(value):
        _cur_health = value
        if _cur_health == 0:
            died.emit()



func _lock_n_load():
    _cur_health = _max_health


func _deal_damage(damage : float):
    _cur_health = clamp(_cur_health - damage, 0, _max_health)

