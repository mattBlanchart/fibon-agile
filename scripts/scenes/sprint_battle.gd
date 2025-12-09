extends Node

# Zones de jeu
@export var hand_area: Control
@export var play_area: Control

# Labels
@export var current_step: Label
@export var sprint_hp_max: int = 20

var deck: Array[CardData]

var sprint_hp: int:
	set(value):
		sprint_hp = value
		# Check sur la texture pour eviter les bugs
		if health_bar: health_bar.value = value
		
		if sprint_hp <= 0:
			get_tree().change_scene_to_file("res://scenes/sprint_retro.tscn")

@onready var health_bar: TextureProgressBar = $MarginContainer/TextureProgressBar

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerState.init() # Init le joueur en debug
	
	health_bar.max_value = sprint_hp_max
	health_bar.value = sprint_hp_max
	sprint_hp = sprint_hp_max
	
	deck = PlayerState.get_current_deck()
	
	_draw_cards(5)
	
	var bouton = $Button
	bouton.text = "Valider"
	bouton.pressed.connect(degat_to_sprint)
	
func degat_to_sprint():
	for child in play_area.get_children():
		sprint_hp -= child.data.value
		deck.push_back(child.data)
		child.queue_free()
		await get_tree().create_timer(0.2).timeout
		
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
		
		var scene_enfant: PackedScene = preload("res://scenes/props/card.tscn")
		var instance_enfant = scene_enfant.instantiate()
		instance_enfant.data = card_data
		instance_enfant.play_requested.connect(_on_card_play_requested)
		
		hand_area.add_child(instance_enfant)
