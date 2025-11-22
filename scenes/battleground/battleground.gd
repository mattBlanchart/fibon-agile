extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var button = $Button
	button.pressed.connect(piocher)  # connect to the method directly
	

func piocher():
	# Récupérer tous les nodes dans le groupe
	var group_nodes = get_tree().get_nodes_in_group("hand")
	
	for node in group_nodes:
		var scene_enfant = load("res://scenes/cardui/card_ui.tscn")
		var instance_enfant = scene_enfant.instantiate()           
		node.add_child(instance_enfant)

	
	
