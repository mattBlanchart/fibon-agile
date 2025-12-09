# unit_data.gd
@tool
extends Resource
## Represente une unite recruter par le joueur
class_name UnitData

## Nom de l'unit
@export var label: String = ""
@export var code: String = ""
@export var add_bug: int = 0
## Est ce que l'unit est upgrade
@export var is_upgraded: bool = false

## Le cout de recrutement de l'unit
@export var cost: int = 0
## La motivation de l'unite. Une fois a 0, l'unite demissionne
@export var stamina: int = 0

@export var cards: Array[CardData] = []

@export var effect_id: String = ""
@export var effect_params: Dictionary = {}
@export var effect_params_upgraded: Dictionary = {}
