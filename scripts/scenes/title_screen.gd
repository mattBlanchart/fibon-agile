extends Control

## Envoie sur la scene de nouveau jeu
func _on_new_game_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/intro.tscn")

## Envoie sur la scene des credits
func _on_credits_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credits.tscn")

## Quitte le jeu
func _on_quit_pressed() -> void:
	get_tree().quit()
