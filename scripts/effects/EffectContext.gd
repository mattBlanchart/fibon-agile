# EffectContext.gd
extends Object
class_name EffectContext

var game_state: BattleGround
var card_data: CardData
var unit_data: UnitData

func _init(_game_state: BattleGround, _card_data: CardData = null, _unit_data: UnitData = null):
	game_state = _game_state
	card_data = _card_data
	unit_data = _unit_data
