extends Control #pour la navigation

var isGoingToRight: bool = true;
var isGoingToLeft: bool = false;
var isGoingDown: bool = false;
var isGoingUp: bool = false;
var speed: int = 200;

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	pass


	
func _process(delta: float) -> void:

	if $CanvasLayer/FloBody2D.position.x >= 120 && $CanvasLayer/FloBody2D.position.y <= 0:
		isGoingToRight = false
		isGoingDown = true
	elif $CanvasLayer/FloBody2D.position.x >= 120 && $CanvasLayer/FloBody2D.position.y >= 200:
		isGoingDown=false
		isGoingToLeft=true
	elif $CanvasLayer/FloBody2D.position.x <= 0 && $CanvasLayer/FloBody2D.position.y >= 200:
		isGoingToLeft=false
		isGoingUp=true
	elif $CanvasLayer/FloBody2D.position.x <= 0 && $CanvasLayer/FloBody2D.position.y <= 0:
		isGoingToRight=true
		isGoingUp=false
		
	if isGoingToRight:
		$CanvasLayer/FloBody2D.position.x += speed	* delta
	elif isGoingToLeft:
		$CanvasLayer/FloBody2D.position.x -= speed	* delta
	elif isGoingDown:
		$CanvasLayer/FloBody2D.position.y += speed	* delta
	elif isGoingUp:
		$CanvasLayer/FloBody2D.position.y -= speed	* delta
	
	print("x = " + str($CanvasLayer/FloBody2D.position.x) + " y = " + str($CanvasLayer/FloBody2D.position.y) + " right = " + str(isGoingToRight) + " left = " + str(isGoingToLeft)
		+ " up = " + str(isGoingUp) + " down = " + str(isGoingDown))
	
func _on_quit_credit_pressed() -> void:
		print("Go to Welcome page")
		get_tree().change_scene_to_file("res://scenes/welcome/welcome.tscn")
