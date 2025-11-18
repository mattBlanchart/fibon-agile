extends Control

# Path to your main game scene
@export var main_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
func _on_start_button_pressed() -> void:
	print("Button clicked!")
	if main_scene:
		get_tree().change_scene_to_packed(main_scene)
	else:
		print("un truc")
