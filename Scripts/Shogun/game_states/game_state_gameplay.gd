class_name GameStateGameplay
extends GameStateKiso


@export var gameplaye_player_shogun : GameplayPlayerShogun


func init(world_teikyou : WorldTeikyou) -> void:
	gameplaye_player_shogun.lock_n_load(world_teikyou.player_teikou)
