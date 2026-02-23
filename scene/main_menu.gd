extends Control

func _ready() -> void:
	if AuthManager.user_id == "":
		get_tree().change_scene_to_file("res://scene/LoginScreen.tscn")

func _on_wardrobe_pressed():
	get_tree().change_scene_to_file("res://scene/wardrobe.tscn")

func _on_town_pressed():
	get_tree().change_scene_to_file("res://scene/game.tscn")
