extends Control


func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		var playedArea = get_tree().get_root().get_node("SprintBattle/PlayAreaContainer/PlayArea")
		var handArea = get_parent()
		if handArea:
			handArea.remove_child(self)
			
		playedArea.add_child(self)
	

func _on_gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_RIGHT:
		var handArea = get_tree().get_root().get_node("SprintBattle/HandArea")
		var playedArea = get_tree().get_root().get_node("SprintBattle/PlayAreaContainer/PlayArea")
		var parentNode = get_parent()
		if parentNode == playedArea:
			playedArea.remove_child(self)
			
			handArea.add_child(self)
		else:
			pass
		
