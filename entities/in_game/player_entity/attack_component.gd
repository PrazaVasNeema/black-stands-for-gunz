class_name AttackComponent
extends Node


func init() -> void:
	pass


func roll_drum(drum_num : int):
	G_ArmoryManager.load_random_gun(drum_num)
