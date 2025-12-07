extends TextureRect

@export var rotation_speed: float = 90.0 # degrees per second
func _ready():
	pivot_offset = size * 0.65

func _process(delta: float) -> void:
	rotation_degrees += rotation_speed * delta
