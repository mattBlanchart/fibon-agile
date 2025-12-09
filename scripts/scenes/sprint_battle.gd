extends Node

# Zones de jeu
@export var hand_area: Control
@export var play_area: Control
@export var hplabel: Label
@export var bugs: Label
@export var fatigue: Label
@export var health_bar: ProgressBar

# Labels
@export var current_step: Label

var scene_enfant: PackedScene = preload("res://scenes/props/card.tscn")
var deck: Array[CardData]

var bug_value: int:
	set(value):
		bug_value = value
		bugs.text = str(value)

var fatigue_value: int:
	set(value):
		fatigue_value = value
		fatigue.text = str(value)

#    Barre de PV, modifier les variables met a jour la barre directement    #
var sprint_hp_max: int:
	set(value):
		sprint_hp_max = value
		if hplabel:
			hplabel.text = "%s / %s" % [sprint_hp, sprint_hp_max]
		if health_bar:
			health_bar.max_value = value
		
var sprint_hp: int:
	set(value):
		sprint_hp = value
		if hplabel:
			hplabel.text = "%s / %s" % [sprint_hp, sprint_hp_max]
		if health_bar:
			var tween = create_tween()
			tween.tween_property(health_bar, "value", value, 0.5) # 0.5s = vitesse

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerState.init() # Init le joueur en debug
	
	# Ici, utiliser GameState.pi et GameState.sprint pour le sprint et le pi courant
	# Mettre en place la formule pour la difficulter
	sprint_hp_max = 5 + GameState.pi + GameState.sprint
	sprint_hp_max += GameState.bugs
	GameState.bugs = 0
	sprint_hp = sprint_hp_max
	
	current_step.text = "PI: %s / Sprint: %s" % [GameState.pi, GameState.sprint]
	
	deck = PlayerState.get_current_deck()
	
	_draw_cards(5)
	
func degat_to_sprint():
	$Button.disabled = true
	# Evite de calculer les tours sans cartes
	var total_dmg: int = 0
	var total_bugs: int = 0
	if play_area.get_child_count() != 0:
		for child in play_area.get_children():
			total_dmg += child.data.value # Fait les degats au boss
			total_bugs += child.data.unit.add_bug
			
			deck.push_back(child.data) # Remet la carte au fond du deck
			child.queue_free() # Supprime le child de play_area
		
		bug_value += total_bugs
		sprint_hp -= total_dmg * (100 - fatigue_value) / 100
		fatigue_value += 5
		
		if sprint_hp <= 0:
			GameState.bugs = bug_value
			get_tree().change_scene_to_file("res://scenes/sprint_retro.tscn")
			
		# Pioche les cartes de debut du nouveau tour
		_draw_cards(PlayerState.drawByTurn)
	$Button.disabled = false
		
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
