# battle_ground.gd
extends Control

@onready var score_label: Label = $ScoreLabel
@onready var play_area: HBoxContainer = $VBoxContainer/PlayPanel/PlayArea
@onready var hand_area: HBoxContainer = $VBoxContainer/HandPanel/HandArea

@export var deck: Array[CardData] = []
# On exporte un tableau de CardData à remplir dans l'éditeur
@export var starting_hand: Array[CardData] = []

func _ready() -> void:
	_spawn_starting_hand()

func _spawn_starting_hand() -> void:
	var card_scene: PackedScene = preload("res://scenes/Card.tscn")
	
	for card_data in starting_hand:
		var card_instance = card_scene.instantiate()
		card_instance.data = card_data
		
		card_instance.play_requested.connect(_on_card_play_requested)
		
		hand_area.add_child(card_instance)

func _on_card_play_requested(card: Card) -> void:
	if card.get_parent() == hand_area:
		# Deplace la carte dans la zone de jeu
		card.reparent(play_area)
		
	elif card.get_parent() == play_area:
		# Deplace la carte dans la main
		card.reparent(hand_area)
		card._reset_value()
	
	# Recalcule le score
	_update_cards_score()
	_calc_score()
	
func _update_cards_score() -> void:
	for card in play_area.get_children():
		card._calculate_value(play_area.get_children())
	
func _calc_score() -> void:
	var total := 0
	
	# Parcours les enfants de la zone de score et y ajoute leurs valeurs
	for child in play_area.get_children():
			total += child.real_value
	
	# Change le texte du label
	score_label.text = "Score: %d" % total
