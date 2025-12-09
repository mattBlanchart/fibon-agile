extends Node

var units = []
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var recompense_unit = Database.units.duplicate()
	recompense_unit.erase("dwc")
	
	var weights = _getWeightListFromDictionary(recompense_unit)

	for i in range(3):
		units.append(_getOneRandomUnitWithWeights(recompense_unit, weights))
		print(units[i])

	

func _on_next_sprint_pressed() -> void:
	GameState.to_next_sprint()
	get_tree().change_scene_to_file("res://scenes/sprint_battle.tscn")
	
func _getOneRandomUnitWithWeights(units: Dictionary[String, UnitData], weights: PackedFloat32Array) -> UnitData:
	var rng = RandomNumberGenerator.new()
	var proba = rng.rand_weighted(weights)
	
	return units[units.keys()[proba]]
	
func _getWeightListFromDictionary(units: Dictionary[String, UnitData]) -> PackedFloat32Array:
	var unit_weight_list=[]
	for key in units:
		unit_weight_list.append(units[key].poids)
		
	return PackedFloat32Array(unit_weight_list)
