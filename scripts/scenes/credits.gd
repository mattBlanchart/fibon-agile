extends Control

func _on_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
	
func _on_arrivee_player_entered_arrivee(body: Variant) -> void:
	%FloBody2D.turn += 1
