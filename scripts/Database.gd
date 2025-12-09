extends Node

var pi_size = 3
var cards: Dictionary[int, CardData] = {}
var units: Dictionary[String, UnitData] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_cards()
	init_units()
	print(units)
	
func init_cards() -> void:
	var dir := DirAccess.open("res://data/cards/")

	if dir:
		for file in dir.get_files():
			if file.ends_with(".tres"):
				var path := "res://data/cards/" + file
				var data := load(path)

				if data is CardData:
					cards[data.value] = data

func init_units() -> void:
	var dir := DirAccess.open("res://data/units/")
	print(dir)
	if dir:
		for file in dir.get_files():
			if file.ends_with(".tres"):
				var path := "res://data/units/" + file
				var data := load(path)

				if data is UnitData:
					units[data.code] = data
