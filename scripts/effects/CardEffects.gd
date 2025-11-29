# CardEffects.gd
extends Object
class_name CardEffects

static func apply_effect(card_data: CardData, ctx: EffectContext) -> void:
	var id: String = card_data.effect_id
	var params: Dictionary = card_data.effect_params
	
	match id:
		"draw_cards":
			_effect_draw_cards(params, ctx)
		"damage":
			pass
		"add_turn":
			pass
		"none":
			pass

# -------- Implémentations d'effets -------- #
static func _effect_draw_cards(params: Dictionary, ctx: EffectContext) -> void:
	var count: int = params.get("count", 1)
	# Exemples: à adapter à ta logique
	# ctx.source_player.draw_cards(count)
	print("Draw", count, "cards pour", ctx.source_player)
