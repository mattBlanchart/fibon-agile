extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerState.reInit() # Re initialise le state du joueur au valeurs par defaut
	await get_tree().create_timer(3.0).timeout
	get_tree().change_scene_to_file("res://scenes/sprint_battle.tscn")
	
func _on_skip_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sprint_battle.tscn")
