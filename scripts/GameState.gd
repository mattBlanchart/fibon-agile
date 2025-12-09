# PLayerState.gd
extends Node

var current_pi: int = 1
var current_sprint: int = 1

func reset() -> void:
	current_pi = 1
	current_sprint = 1
	
	PlayerState.reInit()

func to_next_sprint() -> void:
	current_pi += 1
	current_sprint += 1
