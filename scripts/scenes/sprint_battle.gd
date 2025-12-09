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
	PlayerState.init() # Init le joueur en debug
	SprintState.init()
	
	SprintState.connect("hp_change",update_health_text)
	health_bar.max_value = sprint_hp
	SprintState.hp = sprint_hp
	
	print(PlayerState.units)
	
	for unit in PlayerState.units :
		for card in unit.cards :
			SprintState.deck.append(card)
				
	#$HandArea.add_child(card)
	_draw_cards(5)
	
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
	
		# Clear les cartes jouees
	for child in $PlayAreaContainer/PlayArea.get_children():
		SprintState.deck.push_back(child)
		$PlayAreaContainer/PlayArea.remove_child(child)
		
	# Pioche les cartes de debut du nouveau tour
	_draw_cards(PlayerState.drawByTurn)
		
##########################################################################"	
# Permet de piocher X cartes; 1 par defaut
func _draw_cards(amount: int = 1) -> void:
	for i in range(1, amount + 1):
		print(SprintState.deck.is_empty())
		# Si le deck est vide on s'arrete la et plus de pioche :D
		if SprintState.deck.is_empty(): return
		
		# Take the first card from the deck
		var card = SprintState.deck.pop_front()
		$HandArea.add_child(card)	
