extends Node2D

const CENTER_X = 640
const CENTER_Y = 410

var under_test = false
var selected = false
var lift = Vector2()
var mass = Vector2()

func _ready():
	pass # Replace with function body.

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click"):
		selected = true

func _physics_process(delta):
	var a
	var b
	a = position.x - CENTER_X
	b = position.y - CENTER_Y
	a = a / 2
	b = b / 2
	lift = Vector2(a + CENTER_X, b + CENTER_Y)
	a = a / 3
	b = b / 3
	mass = Vector2(a + CENTER_X, b + CENTER_Y)
	if selected and not under_test:
		global_position = lerp(global_position, get_global_mouse_position(), 15 * delta)
		get_parent().get_node("Center_Lift").global_position = lerp(get_parent().get_node("Center_Lift").global_position, lift, 7 * delta)
		get_parent().get_node("Center_Mass").global_position = lerp(get_parent().get_node("Center_Mass").global_position, mass, 7 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
