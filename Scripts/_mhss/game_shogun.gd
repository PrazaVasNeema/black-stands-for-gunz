class_name GameShogun
extends Node


@export var world_teikyou : WorldTeikyou
@export var game_state_gameplay : GameStateGameplay

@export var testing_build : GunzBuildData


func _ready() -> void:
	if testing_build:
		for i in testing_build.gunz_array.size():
			world_teikyou.player_teikou.equip_gun(testing_build.gunz_array[i], i)
	game_state_gameplay.init(world_teikyou)
