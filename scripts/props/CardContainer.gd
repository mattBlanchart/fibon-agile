extends Node
class_name Card

signal play_requested(card: Card)

@export var data: CardData

@onready var label: Label = %Label

func _ready() -> void:
	if data.value == 0:
		%"café".visible = true
		label.visible = false
	else:
		label.text = str(data.value)
		
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		play_requested.emit(self)
