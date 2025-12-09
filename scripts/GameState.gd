# PLayerState.gd
extends Node

var pi: int = 1
var sprint: int = 1:
	set(value):
		if value % Database.pi_size:
			pi += 1
			sprint = 1
		else:
			sprint = value

func reset() -> void:
	sprint = 1
	PlayerState.reInit()
	
	# Ajoute l'unite de depart au joueur
	PlayerState.units.push_front(Database.units["dwc"])

func to_next_sprint() -> void:
	sprint += 1
