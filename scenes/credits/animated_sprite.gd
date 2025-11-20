extends CharacterBody2D

@onready var _animated_sprite = $AnimationPlayer

func _ready():
		_animated_sprite.play("MB")
