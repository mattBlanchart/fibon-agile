extends Control

# variables pour initialiser les scénes à changer
@export var main_scene: PackedScene
@export var credits_scene: PackedScene
@export var retrospective_scene: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# pour commencer le jeu
func _on_start_button_pressed() -> void:
	if main_scene:
		get_tree().change_scene_to_packed(main_scene)
	else:
		print("un truc")

# pour aller aux crédits
func _on_start_button_credits_pressed() -> void:
	if credits_scene:
		print("Go to credits scene")
		get_tree().change_scene_to_packed(credits_scene)
	else:
		print("un truc")
		
# pour aller à la rétrospective
func _on_start_button_retrospective_pressed() -> void:
	if retrospective_scene:
		print("Go to retrospective scene")
		get_tree().change_scene_to_packed(retrospective_scene)
	else:
		print("un truc")
