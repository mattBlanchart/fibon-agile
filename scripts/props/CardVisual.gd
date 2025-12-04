extends Control   # ou Panel / TextureRect

@export var hover_scale: float = 1.2
@export var hover_lift: float = 40.0
@export var hover_duration: float = 0.08

var _base_scale: Vector2 = Vector2.ONE
var _base_position: Vector2 = Vector2.ZERO
var _hover_tween: Tween = null
var _base_root_z_index: int = 0

func _ready() -> void:
	_base_scale = scale
	_base_position = position          # ON LA FIXE ICI UNE FOIS
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	mouse_filter = Control.MOUSE_FILTER_STOP

	# pivot en bas-centre pour l'effet "sort de la main"
	pivot_offset = Vector2(size.x / 2.0, size.y)

	var root := get_parent()
	if root is Control:
		_base_root_z_index = root.z_index

func _on_mouse_entered() -> void:
	if _hover_tween != null and _hover_tween.is_running():
		_hover_tween.kill()

	var root := get_parent()
	if root is Control:
		root.z_index = _base_root_z_index + 100

	_hover_tween = create_tween()
	_hover_tween.tween_property(
		self,
		"scale",
		_base_scale * hover_scale,
		hover_duration
	)
	_hover_tween.parallel().tween_property(
		self,
		"position",
		_base_position + Vector2(0.0, -hover_lift),
		hover_duration
	)

func _on_mouse_exited() -> void:
	if _hover_tween != null and _hover_tween.is_running():
		_hover_tween.kill()

	var root := get_parent()
	if root is Control:
		root.z_index = _base_root_z_index

	_hover_tween = create_tween()
	_hover_tween.tween_property(
		self,
		"scale",
		_base_scale,
		hover_duration
	)
	_hover_tween.parallel().tween_property(
		self,
		"position",
		_base_position,   # RETOUR EXACT À LA BASE
		hover_duration
	)
