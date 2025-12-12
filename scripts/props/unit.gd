extends Node
class_name Unit

signal choose_requested(unit: UnitData)

@export var data: UnitData
var card_area
var card_scene = preload("res://scenes/props/card.tscn")

func _ready() -> void:
	card_area = $PlayAreaContainer/CardArea
	
	var data_sprite:CompressedTexture2D = load("res://assets/imgs/" + data.sprite)
	$TextureRect.set_texture(data_sprite)
	
	for card in data.cards:
		var card_scene = card_scene.instantiate()
		card_scene.data = card
		card_scene.get_children()[0].get_children()[0].set_texture(load("res://assets/imgs/" + data.sprite))	
		card_area.add_child(card_scene)
		
	$BulleInfo/RichTextLabel.text  = data.description
		
func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		choose_requested.emit(self)


func _on_mouse_entered() -> void:
	$BulleInfo.visible = true
	$Cadre.visible = true

func _on_mouse_exited() -> void:
	$BulleInfo.visible = false
	$Cadre.visible = false
