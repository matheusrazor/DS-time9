extends KinematicBody2D

export (int) var speed = 250
export (float) var rotation_speed = 1.0

onready var steerAnim = $AnimatedSprite

var velocity = Vector2()
var rotation_dir = 0

func get_input():
	rotation_dir = 0
	velocity = Vector2()
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
		if Input.is_action_pressed("right"):
			rotation_dir -= 1
			steerAnim.play("right")
		elif Input.is_action_pressed("left"):
			rotation_dir += 1
			steerAnim.play("left")
		else:
			steerAnim.stop()
			steerAnim.frame = 0
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)
		if Input.is_action_pressed("right"):
			rotation_dir += 1
			steerAnim.play("right")
		elif Input.is_action_pressed("left"):
			rotation_dir -= 1
			steerAnim.play("left")
		else:
			steerAnim.stop()
			steerAnim.frame = 0

func _physics_process(delta):
	get_input()
	rotation += rotation_dir * rotation_speed * delta
	velocity = move_and_slide(velocity)

func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_E and event.pressed:
			$Horn.play()
			yield(get_tree().create_timer(0.5), "timeout")
			$Horn.stop()
			print("Honk")
		get_node("Label").modulate = Color.transparent
	
