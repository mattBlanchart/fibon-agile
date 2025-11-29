# PLayerState.gd
extends Node

# Nombre de tour max pour battre le bosse
var maxTurn: int = 3
var drawByTurn: int = 2

# Nombre de carte piocher au début du combat
var startingDraw: int = 5

# Liste des unite du joueur
var units: Array[UnitData] = []

func reset() -> void:
	maxTurn = 3
	drawByTurn = 2
	startingDraw = 5
	units = []

## Renvoie le deck courant du joueur en fonction des unite recrutes
func get_current_deck() -> Array[CardData]:
	var deck: Array[CardData] = []
	for unit in units:
		deck.append_array(unit.cards.duplicate())
	return deck
