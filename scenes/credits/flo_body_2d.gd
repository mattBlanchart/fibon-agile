extends CharacterBody2D

var medaille_scene: PackedScene = preload("res://scenes/credits/FP/medaille.tscn")

const JUMP_VELOCITY = -400.0

var isGoingToRight: bool = true
var isGoingToLeft: bool = false
var isGoingDown: bool = false
var isGoingUp: bool = false
@export var speed: int = 300
@export var finalTurn: int = 2
var turn: int = 0
var arrivee: bool = false

func _process(_delta):
	print(global_position)
	print(position)
	#print(turn)
	if turn == finalTurn && !arrivee:
		#position image flo
		position= Vector2(455,84)

		#add & position medaille
		var medaille = medaille_scene.instantiate()
		medaille.position = %FloBody2D.position
		$"..".add_child(medaille)
		arrivee = true
	elif !arrivee :
		#print(position)
				
		if isGoingToRight:
			velocity = Vector2.RIGHT * speed
		elif isGoingToLeft:
			velocity = Vector2.LEFT * speed
		elif isGoingDown:
			velocity = Vector2.DOWN * speed
		elif isGoingUp:
			velocity = Vector2.UP * speed
			
		#print(velocity)
		#print(move_and_slide())
		if move_and_slide():
			if position.x >= 610 && position.y <= 105:
				isGoingToRight = false
				isGoingDown = true
			elif position.x >= 610 && position.y >= 300:
				isGoingDown=false
				isGoingToLeft=true
			elif position.x <= 30 && position.y >= 300:
				isGoingToLeft=false
				isGoingUp=true
			elif position.x <= 30 && position.y <= 50:
				isGoingToRight=true
				isGoingUp=false
		
		#print("x = " + str(position.x) + " y = " + str(position.y) + " right = " + str(isGoingToRight) + " left = " + str(isGoingToLeft)
			#+ " up = " + str(isGoingUp) + " down = " + str(isGoingDown))

#func _physics_process(delta: float) -> void:
	## Add the gravity.
	#if not is_on_floor():
		#velocity += get_gravity() * delta
#
	## Handle jump.
	#if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		#velocity.y = JUMP_VELOCITY
#
	## Get the input direction and handle the movement/deceleration.
	## As good practice, you should replace UI actions with custom gameplay actions.
	#var direction := Input.get_axis("ui_left", "ui_right")
	#if direction:
		#velocity.x = direction * speed
	#else:
		#velocity.x = move_toward(velocity.x, 0, speed)
#
	#move_and_slide()
