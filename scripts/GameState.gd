# PLayerState.gd
extends Node

var pi: int = 1
			
var sprint: int = 1:
	set(value):
		if value > Database.pi_size:
			pi += 1
			sprint = 1
		else:
			sprint = value
var bugs: int = 0
var fatigue: int = 0

func reset() -> void:
	sprint = 1
	pi = 1
	PlayerState.reInit()
	
	# Ajoute l'unite de depart au joueur
	PlayerState.units.push_front(Database.units["dwc"])

func to_next_sprint() -> void:
	sprint += 1
	
