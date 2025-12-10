extends Node

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GameState.reset() # Reset l'etat du jeu
	
	# Cinématique de l'intro
	var audio_reveil := AudioStreamPlayer.new()
	audio_reveil.stream = load("res://assets/sound/reveil.mp3")
	add_child(audio_reveil)
	audio_reveil.play()
	$bg_dream.pivot_offset = $bg_dream.size / 2
	await get_tree().create_timer(5.0).timeout
	var audio_bus := AudioStreamPlayer.new()
	audio_bus.stream = load("res://assets/sound/bus_bruit.mp3")
	add_child(audio_bus)
	audio_bus.play()
	$bg_lit.visible = false
	$Label_lit.visible = false
	$bg_bus.visible = true
	$Label_bus.visible = true
	await get_tree().create_timer(4.0).timeout
	var audio_clavier := AudioStreamPlayer.new()
	audio_clavier.stream = load("res://assets/sound/clavier.mp3")
	add_child(audio_clavier)
	audio_clavier.play()
	$bg_bus.visible = false
	$Label_bus.visible = false
	$bg_office.visible = true
	$Label_office.visible = true
	await get_tree().create_timer(4.0).timeout
	var audio_pi := AudioStreamPlayer.new()
	audio_pi.stream = load("res://assets/sound/blablabla.mp3")
	add_child(audio_pi)
	audio_pi.play()
	$bg_office.visible = false
	$Label_office.visible = false
	$bg_pi.visible = true
	$Label_pi.visible = true
	await get_tree().create_timer(4.0).timeout
	var audio_sleep := AudioStreamPlayer.new()
	audio_sleep.stream = load("res://assets/sound/sleep.mp3")
	add_child(audio_sleep)
	audio_sleep.play()
	$bg_pi.visible = false
	$Label_pi.visible = false
	$bg_sleep.visible = true
	$Label_sleep.visible = true
	await get_tree().create_timer(4.0).timeout
	$bg_sleep.visible = false
	$Label_sleep.visible = false
	$bg_dream.visible = true
	$Label_dream.visible = true
	var audio_dream := AudioStreamPlayer.new()
	audio_dream.stream = load("res://assets/sound/lalalalalala.mp3")
	add_child(audio_dream)
	audio_dream.play()
	await get_tree().create_timer(3.2).timeout
	get_tree().change_scene_to_file("res://scenes/sprint_battle.tscn")
	
func _process(delta):
	$bg_dream.rotation_degrees += 90 * delta
	
	
func _on_skip_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/sprint_battle.tscn")
