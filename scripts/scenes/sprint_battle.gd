extends Node

# Zones de jeu
@export var hand_area: Control
@export var play_area: Control

# Labels
@export var current_step: Label
@export var sprint_hp: int = 20


@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar
	

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SprintState.connect("hp_change",update_health_text)
	health_bar.max_value = sprint_hp
	SprintState.hp = sprint_hp
	
	PlayerState.init() # Init le joueur en debug
	print(PlayerState.units)
	for unit in PlayerState.units :
		for card in unit.cards :
			$HandArea.add_child(card)
			print(card.value)
			
	var bouton = $Button
	bouton.text = "Valider"
	bouton.pressed.connect(degat_to_sprint)
	add_child(bouton)
				
func update_health_text():
	health_bar.value = SprintState.hp
	
	
func degat_to_sprint():
	for cards in $PlayAreaContainer/PlayArea.get_children(false):
		SprintState.hp -= cards.value
		print($PlayAreaContainer/PlayArea)
		print(SprintState.hp)
	

	
	
