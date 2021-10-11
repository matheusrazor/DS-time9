extends Node2D

var drag16
var drag16_2
var drag32
var drag32_2
var drag48
var drag64

func _ready():
	drag16 = get_tree().get_nodes_in_group("drag16")
	drag16_2 = get_tree().get_nodes_in_group("drag16_2")
	drag32 = get_tree().get_nodes_in_group("drag32")
	drag32_2 = get_tree().get_nodes_in_group("drag32_2")
	drag48 = get_tree().get_nodes_in_group("drag48")
	drag64 = get_tree().get_nodes_in_group("drag64")
	
func _process(delta):
	if get_node("CompileButton").pressed == true:
		var result = passed_or_failed()
		get_node("Animations").which_one(result)

func passed_or_failed():
	var aux = 1
	
	var strSpot = []
	var strDrag = []
	
	var strSpot2 = []
	var strDrag2 = []
	
	for drag_obj in drag16:
		strSpot = str(get_node("Dropzone16_2").global_position)
		strDrag = str(drag_obj.global_position)
		for letter in strSpot:
			strSpot2.append(letter)
			if letter == ".":
				break
		for letter in strDrag:
			strDrag2.append(letter)
			if letter == ".":
				break
		print(drag_obj.global_position)
		if strSpot2 != strDrag2:
			aux = 0
	strSpot2.clear()
	strDrag2.clear()
	
	for drag_obj in drag16_2:
		strSpot = str(get_node("Dropzone16_1").global_position)
		strDrag = str(drag_obj.global_position)
		for letter in strSpot:
			strSpot2.append(letter)
			if letter == ".":
				break
		for letter in strDrag:
			strDrag2.append(letter)
			if letter == ".":
				break
		print(drag_obj.global_position)
		if strSpot2 != strDrag2:
			aux = 0
	strSpot2.clear()
	strDrag2.clear()
	
	for drag_obj in drag32:
		strSpot = str(get_node("Dropzone32_2").global_position)
		strDrag = str(drag_obj.global_position)
		for letter in strSpot:
			strSpot2.append(letter)
			if letter == ".":
				break
		for letter in strDrag:
			strDrag2.append(letter)
			if letter == ".":
				break
		print(drag_obj.global_position)
		if strSpot2 != strDrag2:
			aux = 0
	strSpot2.clear()
	strDrag2.clear()
	
	for drag_obj in drag32_2:
		strSpot = str(get_node("Dropzone32_1").global_position)
		strDrag = str(drag_obj.global_position)
		for letter in strSpot:
			strSpot2.append(letter)
			if letter == ".":
				break
		for letter in strDrag:
			strDrag2.append(letter)
			if letter == ".":
				break
		print(drag_obj.global_position)
		if strSpot2 != strDrag2:
			aux = 0
	strSpot2.clear()
	strDrag2.clear()
	
	for drag_obj in drag48:
		strSpot = str(get_node("Dropzone48_1").global_position)
		strDrag = str(drag_obj.global_position)
		for letter in strSpot:
			strSpot2.append(letter)
			if letter == ".":
				break
		for letter in strDrag:
			strDrag2.append(letter)
			if letter == ".":
				break
		print(drag_obj.global_position)
		if strSpot2 != strDrag2:
			aux = 0
	strSpot2.clear()
	strDrag2.clear()
	
	for drag_obj in drag64:
		strSpot = str(get_node("Dropzone64_1").global_position)
		strDrag = str(drag_obj.global_position)
		for letter in strSpot:
			strSpot2.append(letter)
			if letter == ".":
				break
		for letter in strDrag:
			strDrag2.append(letter)
			if letter == ".":
				break
		print(drag_obj.global_position)
		if strSpot2 != strDrag2:
			aux = 0
	strSpot2.clear()
	strDrag2.clear()
	
	return aux
