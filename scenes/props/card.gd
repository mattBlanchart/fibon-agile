extends Control

@export var value: int = 0

signal play_requested()

# Appeler cette méthode pour initialiser les variables de l'unité après création
func initialize(value: int ):
	$".".value = value
	$Control/ContentMargin/Label.text = str(value)
	
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		play_requested.emit()
