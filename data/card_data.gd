# card_data.gd
extends Resource
class_name CardData

@export var value: int = 0
@export_enum("none", "draw_cards", "damage", "add_turn") var effect_id: String = "none"
@export var effect_params: Dictionary = {}

var unit: UnitData
