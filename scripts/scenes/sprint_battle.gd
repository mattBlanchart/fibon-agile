extends Node

# Zones de jeu
@export var hand_area: Control
@export var play_area: Control

# Labels
@export var current_step: Label
@export var sprint_hp: Label


@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SprintState.connect("hp_change",update_health_text)
	update_health_text()
	
	PlayerState.init() # Init le joueur en debug
	print(PlayerState.units)
	for unit in PlayerState.units :
		for card in unit.cards :
			$HandArea.add_child(card)
			print(card.value)
	
	
			
func update_health_text():
	health_bar.value = SprintState.hp
	
	
	
