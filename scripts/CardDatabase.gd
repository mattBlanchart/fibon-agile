extends Node

var cards: Dictionary[int, CardData] = {}

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var dir := DirAccess.open("res://data/cards/")

	if dir:
		for file in dir.get_files():
			if file.ends_with(".tres"):
				var path := "res://data/cards/" + file
				var data := load(path)

				if data is CardData:
					cards[data.value] = data
