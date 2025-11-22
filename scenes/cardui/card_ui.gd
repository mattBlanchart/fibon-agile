class_name card_ui
extends Control

@onready var value = $Value

var _card_value = ["0.5", "1", "2", "3", "5", "8", "13", "20", "40", "100", "∞", "café"]


func _ready():
	randomize()
	if value == null:
		print("ERREUR : Le nœud 'Value' est introuvable !")
		return

	value.text = get_card_value()
	value.add_theme_color_override("font_color", Color.BLACK)

func get_card_value():
	var random_card_value = _card_value[randi() % _card_value.size()]
	return random_card_value
