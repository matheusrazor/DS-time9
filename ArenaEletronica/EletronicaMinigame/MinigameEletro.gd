extends Node2D

func _ready():
	get_node("Background/ledOn").modulate = Color.transparent
	yield(get_tree().create_timer(5.0), "timeout")
	get_node("Label").visible = false

onready var success = $SuccessPanel

func _process(delta):
	if get_node("CheckButton").pressed == true:
		if conditions_met():
			get_node("Background/ledOn").modulate = Color.white
			yield(get_tree().create_timer(1.0), "timeout")
			get_node("SuccessPanel").visible = true
			success.play("success")

func conditions_met():
	var aux = true
	var bc1 = get_node("SpinBC_1")
	var bc2 = get_node("SpinBC_2")
	var bc3 = get_node("SpinBC_3")
	var oh220 = get_node("Spin220Ohm")
	var oh100k = get_node("Spin100kOhm")
	var oh1m = get_node("Spin1MOhm")
	
	if not bc1.correct_angle():
		aux = false
	if not bc2.correct_angle():
		aux = false
	if not bc3.correct_angle():
		aux = false
	if not oh220.correct_angle():
		aux = false
	if not oh100k.correct_angle():
		aux = false
	if not oh1m.correct_angle():
		aux = false
	
	return aux
	
func blink():
	get_node("Background/ledOn").modulate = Color.white
	yield(get_tree().create_timer(1.0), "timeout")
	get_node("Background/ledOn").modulate = Color.transparent
