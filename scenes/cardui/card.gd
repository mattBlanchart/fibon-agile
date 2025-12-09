# card.gd
extends Control

signal play_requested(card: Card)

@export var data: CardData

@onready var value_label: Label = $Value
@onready var label_label: Label = $Label
@onready var real_value: int

func _ready() -> void:
	if data:
		real_value = data.value
		value_label.visible = false
		label_label.text = str(data.value)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		play_requested.emit(self)

func _calculate_value(played_cards: Array[Node]) -> void:
	var value = data.value
	
	for played_card in played_cards:
		if played_card is Card:
			value = _apply_effect(played_card, value)
		
	_update_value(value)

func _update_value(value: int) -> void:
	real_value = value
	value_label.text = str(real_value)
	value_label.visible = data.value != real_value

func _reset_value() -> void:
	_update_value(data.value)

func _apply_effect(played_card: Card, value: int) -> int:
	if played_card == self:
		return value
	
	if played_card.data == null:
		return value
		
	if played_card.data.effect_id == "":
		return value
		
	match played_card.data.effect_id:
		"add_if_equals":
			if self.data.value == played_card.data.effect_params.get("target"):
				return value + played_card.data.effect_params.get("value")
		"sub_if_equals":
			if self.data.value == played_card.data.effect_params.get("target"):
				return value - played_card.data.effect_params.get("value")
		"set_if_equals":
			if self.data.value == played_card.data.effect_params.get("target"):
				return played_card.data.effect_params.get("value")
			
	return value
