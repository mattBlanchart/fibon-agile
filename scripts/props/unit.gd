extends Control

@export var data: UnitData
var card_area 

var card_scene = preload("res://scenes/props/card.tscn")

func _ready() -> void:
	card_area = $PlayAreaContainer/CardArea
	
	var sprite:CompressedTexture2D = load("res://assets/imgs/" + data.sprite)
	print("res://assets/imgs/" + data.sprite)
	$TextureRect.set_texture(sprite)
	
	
	print(data.cards)
	for card in data.cards:
		var card_scene = card_scene.instantiate()
		print(card.value)
		card_scene.data = card			
		card_area.add_child(card_scene)
