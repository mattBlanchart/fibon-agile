# battle_ground.gd
extends Control

@onready var score_label: Label = $ScoreLabel
@onready var play_area: HBoxContainer = $VBoxContainer/PlayPanel/PlayArea
@onready var hand_area: HBoxContainer = $VBoxContainer/HandPanel/HandArea
@onready var currentDamage: int:
	set(value): # Le setter pour mettre a jour le label automatiquement
		currentDamage = value
		$ScoreLabel.text = "Score: %d" % currentDamage

# Point de vie du boss
@export var boss_hp: int = 10:
	set(value):
		boss_hp = max(0, value) # Evite de descendre en dessous de 0
		$BossHP.text = str(boss_hp)

# Le deck du joueur pour ce combat, on evite d'utiliser celui de PlayerState
var deck: Array[CardData] = []

func _ready() -> void:
	# Cree un deck random pour le debug
	var ms: String = ProjectSettings.get_setting("application/run/main_scene")
	var cs: String = get_tree().current_scene.scene_file_path
	if OS.has_feature("editor") and cs != ms:
		PlayerState._battleground_debug()
	
	# Initialise le label des pv du boss
	$BossHP.text = str(boss_hp)
	
	# Initialise le deck du joueur
	deck = PlayerState.deck.duplicate()
	deck.shuffle() # Randomise la liste des cartes
	_draw_cards(PlayerState.startingDraw)
	
	# Met en place les signaux des boutons
	$DrawButton.pressed.connect(_draw_cards)
	$EndTurn.pressed.connect(_end_turn)

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
	currentDamage = 0 # Reset les degats
	
	# Parcours les enfants de la zone de score et y ajoute leurs valeurs
	for child in play_area.get_children():
		currentDamage += child.real_value

# Permet de piocher X cartes; 1 par defaut
func _draw_cards(amount: int = 1) -> void:
	for i in range(1, amount + 1):
		# Si le deck est vide on s'arrete la et plus de pioche :D
		if deck.is_empty(): return
		
		# Take the first card from the deck
		var card_data = deck.pop_front()
		
		var scene_enfant: PackedScene = preload("res://scenes/cardui/Card.tscn")
		var instance_enfant = scene_enfant.instantiate()
		instance_enfant.data = card_data
		instance_enfant.play_requested.connect(_on_card_play_requested)
		
		hand_area.add_child(instance_enfant)

# Fonction qui met fin au tour
func _end_turn() -> void:
	# Fait les degats au boss
	boss_hp -= currentDamage
	
	# Clear les cartes jouees
	for child in play_area.get_children():
		child.queue_free()
	
	# Reset les degats
	currentDamage = 0
	
	# Pioche les cartes de debut du nouveau tour
	_draw_cards(PlayerState.drawByTurn)
