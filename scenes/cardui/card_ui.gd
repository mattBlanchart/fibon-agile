extends Node2D

@export var card_texture: Texture

func _ready():
	$Sprite2D.texture = card_texture

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
