# PLayerState.gd
extends Node

# Nombre de tour max pour battre le bosse
var maxTurn: int = 3
var drawByTurn: int = 2

# Nombre de carte piocher au début du combat
var startingDraw: int = 5

# Deck du joueur pendant un combat
var deck: Array[CardData] = []

func _battleground_debug() -> void:
	# Va chercher la liste des cartes depuis les fichiers
	var dir := DirAccess.open("res://data/cards/")
	var tres_files: Array[String] = []
	
	for file in dir.get_files():
		if file.ends_with(".tres"):
			tres_files.append("res://data/cards/" + file)
	
	# Anti bug mais ca sert a rien
	if tres_files.is_empty():
		return
	
	# Prend 15 cartes au hasard
	for i in range(1, 15):
		var random_file := tres_files[randi() % tres_files.size()]
		deck.append(load(random_file))
		
