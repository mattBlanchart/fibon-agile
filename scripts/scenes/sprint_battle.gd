extends Node

# Zones de jeu
@export var hand_area: Control
@export var play_area: Control

# Labels
@export var current_step: Label

var scene_enfant: PackedScene = preload("res://scenes/props/card.tscn")
var deck: Array[CardData]

#    Barre de PV, modifier les variables met a jour la barre directement    #
var sprint_hp_max: int:
	set(value):
		if health_bar: health_bar.max_value = value
		
var sprint_hp: int:
	set(value):
		sprint_hp = value
		if health_bar: health_bar.value = value

@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerState.init() # Init le joueur en debug
	
	# Ici, utiliser GameState.pi et GameState.sprint pour le sprint et le pi courant
	# Mettre en place la formule pour la difficulter
	sprint_hp_max = 5 + ((GameState.pi - 1) * 15) + ((GameState.sprint - 1) * 5)
	sprint_hp = sprint_hp_max
	
	current_step.text = "PI: {} / Sprint: {}".format([GameState.pi, GameState.sprint])
	
	deck = PlayerState.get_current_deck()
	
	_draw_cards(5)
	
func degat_to_sprint():
	for child in play_area.get_children():
		sprint_hp -= child.data.value
		deck.push_back(child.data)
		child.queue_free()
		if sprint_hp > 0:
			await get_tree().create_timer(0.2).timeout
		
	if sprint_hp <= 0:
		get_tree().change_scene_to_file("res://scenes/sprint_retro.tscn")
	# Pioche les cartes de debut du nouveau tour
	_draw_cards(PlayerState.drawByTurn)
		
##########################################################################"	
func _on_card_play_requested(card: Card) -> void:
	if card.get_parent() == hand_area:
		# Deplace la carte dans la zone de jeu
		card.reparent(play_area)
		
	elif card.get_parent() == play_area:
		# Deplace la carte dans la main
		card.reparent(hand_area)

func _draw_cards(amount: int = 1) -> void:
	for i in range(1, amount + 1):
		# Si le deck est vide on s'arrete la et plus de pioche :D
		if deck.is_empty(): return
		
		# Take the first card from the deck
		var card_data = deck.pop_front()
		
		var instance_enfant = scene_enfant.instantiate()
		instance_enfant.data = card_data
		instance_enfant.play_requested.connect(_on_card_play_requested)
		
		hand_area.add_child(instance_enfant)
