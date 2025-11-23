extends CharacterBody2D


@onready var _sprite_ryu = $Ryu

func _ready():
		_sprite_ryu.play("Ryu")
