extends CharacterBody2D

var medaille_scene: PackedScene = preload("res://scenes/credits/FP/medaille.tscn")

var isGoingToRight: bool = true
var isGoingToLeft: bool = false
var isGoingDown: bool = false
var isGoingUp: bool = false
@export var speed: int = 400
@export var finalTurn: int = 2
var turn: int = -1
var arrivee: bool = false
var init_position = Vector2(0,0);

func _ready() -> void:
	init_position = position

func _process(_delta):
	if turn == finalTurn && !arrivee:
		#position image flo
		position=  init_position

		#add & position medaille
		var medaille = medaille_scene.instantiate()
		medaille.position = %FloBody2D.position
		$"..".add_child(medaille)
		arrivee = true
	elif !arrivee :				
		if isGoingToRight:
			velocity = Vector2.RIGHT * speed
		elif isGoingToLeft:
			velocity = Vector2.LEFT * speed
		elif isGoingDown:
			velocity = Vector2.DOWN * speed
		elif isGoingUp:
			velocity = Vector2.UP * speed
				
		if move_and_slide():
			if isGoingToRight && !isGoingToLeft && !isGoingDown && !isGoingUp:
				isGoingToRight = false
				isGoingDown = true
			elif isGoingDown && !isGoingToRight && !isGoingToLeft  && !isGoingUp:
				isGoingDown=false
				isGoingToLeft=true
			elif isGoingToLeft &&!isGoingToRight &&  !isGoingDown && !isGoingUp:
				isGoingToLeft=false
				isGoingUp=true
			elif isGoingUp && !isGoingToRight && !isGoingToLeft && !isGoingDown:
				isGoingToRight=true
				isGoingUp=false

			#print("x = " + str(position.x) + " y = " + str(position.y) + " right = " + str(isGoingToRight) + " left = " + str(isGoingToLeft)
			#+ " up = " + str(isGoingUp) + " down = " + str(isGoingDown))
