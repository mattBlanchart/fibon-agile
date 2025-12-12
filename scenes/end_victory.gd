extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	var defeat := AudioStreamPlayer.new()
	defeat.stream = load("res://assets/sound/excellent.mp3")
	add_child(defeat)
	defeat.play()


func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
