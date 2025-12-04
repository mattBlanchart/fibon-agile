extends Control

@export var radius: float = 800.0
@export var angle_per_card_deg: float = 4.0
@export var max_arc_angle_deg: float = 60.0
@export var baseline_from_bottom: float = 20.0

func _ready() -> void:
	_layout_cards()
	child_entered_tree.connect(_on_child_changed)
	child_exiting_tree.connect(_on_child_changed)

func _on_child_changed(_node: Node) -> void:
	await get_tree().process_frame
	_layout_cards()

func _layout_cards() -> void:
	var cards: Array[Control] = []
	for child in get_children():
		if child is Control:
			cards.append(child)

	var count := cards.size()
	if count == 0:
		return

	var total_angle_deg: float = angle_per_card_deg * float(max(0, count - 1))
	total_angle_deg = min(total_angle_deg, max_arc_angle_deg)
	var arc_angle: float = deg_to_rad(total_angle_deg)

	var baseline_y: float = size.y - baseline_from_bottom
	var circle_center := Vector2(
		size.x / 2.0,
		baseline_y + radius
	)

	for i in range(count):
		var card := cards[i]

		var t := 0.0
		if count > 1:
			t = float(i) / float(count - 1) - 0.5

		var angle := t * arc_angle

		# pivot au bas-centre de CardRoot
		card.pivot_offset = Vector2(card.size.x / 2.0, card.size.y)

		var pivot_point := circle_center + Vector2(
			sin(angle) * radius,
			-cos(angle) * radius
		)

		var target_pos := pivot_point - card.pivot_offset
		var target_rot := angle * 0.9

		var tween := create_tween()
		tween.tween_property(card, "position", target_pos, 0.15)
		tween.tween_property(card, "rotation", target_rot, 0.15)
