# SprintState.gd
extends Node

signal hp_change

var hp = 50:
	get:
		return hp
	set(value):
		hp = value
		hp_change.emit()
