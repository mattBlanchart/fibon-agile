extends Control

var carte_scene: PackedScene = preload("res://scenes/cardui/Card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var carte = carte_scene.instantiate()
	add_child(carte)
	carte.position = Vector2(50,50)
	add_child(carte)
	add_child(carte)

func _on_quit_credit_pressed() -> void:
		print("Go to Welcome page")
		get_tree().change_scene_to_file("res://scenes/welcome/welcome.tscn")
