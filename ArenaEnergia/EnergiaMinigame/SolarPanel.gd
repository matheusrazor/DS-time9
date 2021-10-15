extends Node2D

var positioned = false
var selected = false
var rest_point
var rest_nodes = []

func _ready():
	rest_point = global_position
	rest_nodes = get_tree().get_nodes_in_group("frames")

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and not positioned:
		selected = true
		z_index = 1

func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)

func _input(event):
	if event is InputEventMouseButton:
		rest_nodes = get_tree().get_nodes_in_group("frames")
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			z_index = 0
			for child in rest_nodes:
				print(child.global_position.x)
				var distance = global_position.distance_to(child.global_position)
				if distance < 100:
					rest_point = child.global_position
					positioned = true
					child.occupied()
					get_parent().progress_bar()
					print(global_position)
