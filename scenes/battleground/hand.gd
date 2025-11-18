extends Node2D

@export var card_scene: PackedScene
@export var overlap: float = 30   # How much each card overlaps
@export var fan_angle: float = 15 # Maximum rotation for fanned look
@export var layout_horizontal: bool = true

var cards: Array = []

# Call this to populate the hand
func set_hand(textures: Array):
	# Clear previous cards
	for c in cards:
		c.queue_free()
	cards.clear()
	
	var count = textures.size()
	if count == 0:
		return

	# Create new cards
	for i in range(count):
		var card = card_scene.instantiate()
		card.card_texture = textures[i]
		add_child(card)
		cards.append(card)

	_arrange_cards()

# Internal function to arrange cards
func _arrange_cards():
	var count = cards.size()
	if count == 0:
		return

	var total_overlap = overlap * (count - 1)
	var start_pos = -total_overlap / 2  # center the hand

	for i in range(count):
		var card = cards[i]
		if layout_horizontal:
			card.position = Vector2(start_pos + i * overlap, 0)
			# Calculate fanning rotation
			var rot = -fan_angle/2 + i * (fan_angle / max(count-1, 1))
			card.rotation_degrees = rot
		else:
			card.position = Vector2(0, start_pos + i * overlap)
			var rot = -fan_angle/2 + i * (fan_angle / max(count-1, 1))
			card.rotation_degrees = rot
