class_name GameShogun
extends Node


@export var world_teikyou : WorldTeikyou
@export var input_service : InputService
@export var game_state_gameplay : GameStateGameplay

@export var testing_build : GunzBuildData


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if testing_build:
		for i in testing_build.gunz_array.size():
			world_teikyou.player_teikou.equip_gun(testing_build.gunz_array[i], i)
	game_state_gameplay.init(world_teikyou, input_service)
