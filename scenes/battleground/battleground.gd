extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var textures = [
		preload("res://assets/cards/card_05.png"),
		preload("res://assets/cards/card_05.png"),
		preload("res://assets/cards/card_05.png")
	]

	$Hand.set_hand(textures)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
