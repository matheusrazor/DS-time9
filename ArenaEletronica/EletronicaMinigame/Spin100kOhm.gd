extends Node2D

var selected = false

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and not correct_angle():
		selected = true
		get_node("Highlight").visible = false
		
func _input(event):
	if event is InputEventMouseButton and selected:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			global_rotation_degrees += 90.0
			if correct_angle():
				get_parent().blink()
			print(global_rotation_degrees)
			
func correct_angle():
	var aux = false
	var strAngle = str(global_rotation_degrees)
	if strAngle == "-89.999786":
		aux = true
	return aux
