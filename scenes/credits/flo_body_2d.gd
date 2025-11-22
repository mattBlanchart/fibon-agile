extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

var isGoingToRight: bool = true;
var isGoingToLeft: bool = false;
var isGoingDown: bool = false;
var isGoingUp: bool = false;
var speed: int = 200;

func _process(_delta):
	print(position)
			
	if isGoingToRight:
		velocity = Vector2.RIGHT * speed
	elif isGoingToLeft:
		velocity = Vector2.LEFT * speed
	elif isGoingDown:
		velocity = Vector2.DOWN * speed
	elif isGoingUp:
		velocity = Vector2.UP * speed
		
	print(velocity)
	print(move_and_slide())
	if move_and_slide():
		if position.x >= 120 && position.y <= 0:
			isGoingToRight = false
			isGoingDown = true
		elif position.x >= 120 && position.y >= 200:
			isGoingDown=false
			isGoingToLeft=true
		elif position.x <= -426 && position.y >= 200:
			isGoingToLeft=false
			isGoingUp=true
		elif position.x <= -420 && position.y <= -30:
			isGoingToRight=true
			isGoingUp=false
	
	print("x = " + str(position.x) + " y = " + str(position.y) + " right = " + str(isGoingToRight) + " left = " + str(isGoingToLeft)
		+ " up = " + str(isGoingUp) + " down = " + str(isGoingDown))

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
		#velocity.x = direction * SPEED
	#else:
		#velocity.x = move_toward(velocity.x, 0, SPEED)
#
	#move_and_slide()
