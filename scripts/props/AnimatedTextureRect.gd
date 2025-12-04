extends TextureRect

@export var columns: int = 4                 # nb de colonnes dans le sprite sheet
@export var rows: int = 4                    # nb de lignes
@export var frames_in_animation: int = 0     # 0 = utiliser toutes les frames
@export var fps: float = 8.0                 # vitesse de l’anim
@export var start_delay: float = 2.0         # secondes avant de commencer
@export var play_once: bool = true           # ne pas loop

var _frames: Array[Texture2D] = []
var _time := 0.0
var _index := 0
var _playing := false
var _source_texture: Texture2D


func _ready() -> void:
	# On utilise la texture déjà mise sur le TextureRect comme sprite sheet
	_source_texture = texture
	_build_frames()

	if _frames.size() > 0:
		texture = _frames[0]

	# Lancer l’animation après un délai
	await get_tree().create_timer(start_delay).timeout
	_playing = true


func _process(delta: float) -> void:
	if not _playing:
		return
	if _frames.is_empty():
		return

	_time += delta
	var frame_duration := 1.0 / fps

	if _time >= frame_duration:
		_time -= frame_duration
		_index += 1

		# Si on ne loop pas
		if play_once and _index >= _frames.size():
			_index = _frames.size() - 1   # reste sur la dernière frame
			_playing = false
			return

		# Si on loop (au cas où tu mets play_once = false)
		_index = _index % _frames.size()

		texture = _frames[_index]


func _build_frames() -> void:
	_frames.clear()

	if _source_texture == null:
		return

	var tex: Texture2D = _source_texture

	# Si jamais tu avais mis déjà un AtlasTexture, on récupère l’atlas
	if tex is AtlasTexture:
		tex = (tex as AtlasTexture).atlas

	var tex_size: Vector2 = tex.get_size()
	if columns <= 0 or rows <= 0:
		return

	var frame_w: float = tex_size.x / columns
	var frame_h: float = tex_size.y / rows

	var total_frames := columns * rows
	var limit := frames_in_animation
	if limit <= 0 or limit > total_frames:
		limit = total_frames

	for i in range(limit):
		var col := i % columns
		var row := i / columns

		var region := Rect2(col * frame_w, row * frame_h, frame_w, frame_h)

		var atlas := AtlasTexture.new()
		atlas.atlas = tex
		atlas.region = region

		_frames.append(atlas)
