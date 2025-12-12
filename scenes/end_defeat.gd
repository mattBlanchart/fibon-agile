extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(2.0).timeout
	var defeat := AudioStreamPlayer.new()
	defeat.stream = load("res://assets/sound/c_nul.mp3")
	add_child(defeat)
	defeat.play()
