extends Node2D

var compiling = false
var selected = false
var rest_point
var rest_nodes = []
var rest_default = []
var drag_objects = []

func _ready():
	drag_objects = get_tree().get_nodes_in_group("drag16")
	rest_default = get_tree().get_nodes_in_group("default16_2")
	rest_nodes = get_tree().get_nodes_in_group("zone16")
	rest_point = rest_default[0].global_position
	rest_default[0].select()

func _on_Area2D_input_event(viewport, event, shape_idx):
	if Input.is_action_just_pressed("click") and not compiling:
		selected = true
		z_index = 2
		
func _physics_process(delta):
	if selected:
		global_position = lerp(global_position, get_global_mouse_position(), 25 * delta)
	else:
		global_position = lerp(global_position, rest_point, 10 * delta)

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT and not event.pressed:
			selected = false
			z_index = 1
			var shortest_dist = 100
			var takeaway = 1
			for child in rest_nodes:
				var distance = global_position.distance_to(child.global_position)
				if distance < shortest_dist and is_vacant(child.global_position):
					child.select()
					rest_point = child.global_position
					shortest_dist = distance
					takeaway = 0
			if takeaway == 1:
				rest_point = rest_default[0].global_position

func is_vacant(vacancy):
	var aux = true
	var strVacan = str(vacancy)
	var strVacan2 = []
	var strDrag2 = []
	print(strVacan)
	for drag_obj in drag_objects:
		var strDrag = str(drag_obj.global_position)
		for letter in strVacan:
			strVacan2.append(letter)
			if letter == ".":
				break
		for letter in strDrag:
			strDrag2.append(letter)
			if letter == ".":
				break
		print(drag_obj.global_position)
		if strVacan2 == strDrag2:
			aux = false
	strVacan2.clear()
	strDrag2.clear()
	return aux
