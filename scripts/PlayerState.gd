# PLayerState.gd
extends Node

var isInit: bool = false

# Nombre de tour max pour battre le bosse
var maxTurn: int = 3
var drawByTurn: int = 4

# Nombre de carte piocher au début du combat
var startingDraw: int = 5

# Liste des unite du joueur
var units = []

## Methodes d'initialisation
func init() -> void:
	if !isInit:
		isInit = true
		
		maxTurn = 3
		drawByTurn = 5
		startingDraw = 5
		units = []

func reInit() -> void:
	isInit = false
	init()

## Renvoie le deck courant du joueur en fonction des unite recrutes
func get_current_deck() -> Array[CardData]:
	var deck: Array[CardData] = []
	for unit in units:
		for card in unit.cards:
			var new_card = card.duplicate()
			new_card.unit = unit
			deck.append(new_card)
	return deck
