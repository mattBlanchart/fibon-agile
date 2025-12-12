extends Node

var pi_size = 3
var cards: Dictionary[int, CardData] = {}
var units: Dictionary[String, UnitData] = {}

var card_1 = preload("res://data/cards/001.tres")
var card_2 = preload("res://data/cards/002.tres")
var card_3 = preload("res://data/cards/003.tres")
var card_5 = preload("res://data/cards/005.tres")
var card_8 = preload("res://data/cards/008.tres")
var card_13 = preload("res://data/cards/013.tres")
var card_21 = preload("res://data/cards/021.tres")
var card_cafe = preload("res://data/cards/cafe.tres")
var card_m5 = preload("res://data/cards/m05.tres")

var unit_ba = preload("res://data/units/ba.tres")
var unit_dwc = preload("res://data/units/dev_0.tres")
var unit_dj= preload("res://data/units/dev_1.tres")
var unit_de= preload("res://data/units/dev_2.tres")
var unit_stg = preload("res://data/units/stg.tres")
var unit_archi = preload("res://data/units/archi.tres")


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	init_cards()
	init_units()

func init_cards() -> void:
	var cards_data = [card_1,card_2,card_3,card_5,card_8,card_13,card_21,card_cafe,card_m5]

	if cards_data:
		for card_data in cards_data:
			if card_data is CardData:
				cards[card_data.value] = card_data
	
func init_units() -> void:
	var units_data = [unit_ba,unit_dwc,unit_dj,unit_de,unit_stg,unit_archi]

	if units_data:
		for unit_data in units_data:
			if unit_data is UnitData:
				units[unit_data.code] = unit_data
