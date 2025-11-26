extends Sprite2D

var carte: PackedScene = preload("res://scenes/cardui/Card.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CardUI.position.x=50 # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
