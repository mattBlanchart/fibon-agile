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
		$Sprite2D.rotation -= 90
		$Sprite2D.flip_h = false
		$AnimationPlayer.stop()
		#add & position medaille
		var medaille = medaille_scene.instantiate()
		medaille.position = Vector2(%FloBody2D.position.x + 60,%FloBody2D.position.y - 20)
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
				$Sprite2D.rotation += 90
			elif isGoingDown && !isGoingToRight && !isGoingToLeft  && !isGoingUp:
				isGoingDown=false
				isGoingToLeft=true
				$Sprite2D.rotation -= 90
				$Sprite2D.flip_h = true
			elif isGoingToLeft &&!isGoingToRight &&  !isGoingDown && !isGoingUp:
				isGoingToLeft=false
				isGoingUp=true
				$Sprite2D.rotation += 90
			elif isGoingUp && !isGoingToRight && !isGoingToLeft && !isGoingDown:
				isGoingToRight=true
				isGoingUp=false
				$Sprite2D.rotation -= 90
				$Sprite2D.flip_h = false

			#print("x = " + str(position.x) + " y = " + str(position.y) + " right = " + str(isGoingToRight) + " left = " + str(isGoingToLeft)
			#+ " up = " + str(isGoingUp) + " down = " + str(isGoingDown))
