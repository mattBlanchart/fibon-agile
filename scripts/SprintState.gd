# SprintState.gd
extends Node

signal hp_change

var hp:
	get:
		return hp
	set(value):
		hp = value
		hp_change.emit()
		
var deck = Array();
