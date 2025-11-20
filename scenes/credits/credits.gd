extends Control #pour la navigation


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	pass
	
func _on_quit_credit_pressed() -> void:
		print("Go to Welcome page")
		get_tree().change_scene_to_file("res://scenes/welcome/welcome.tscn")
