extends Node2D

var zoom_in = Vector2(0.6, 0.6)
var zoom_out = Vector2(1, 1)

onready var mass = get_node("Center_Mass")
onready var lift = get_node("Center_Lift")
onready var center = get_node("Center")
onready var camera = get_node("Camera2D")
onready var fan = $Fan
onready var success = $SuccessPanel

func _ready():
	camera.position = center.position
	camera.set_zoom(zoom_in)
	fan.frame = 0
	
func _process(delta):
	var distance = lift.global_position.distance_to(center.global_position)
	if get_node("ButtonTest").pressed:
		get_node("ButtonTest").disabled = true
		get_node("ButtonTest/Label").visible = false
		wind_tunnel()
		yield(get_tree().create_timer(6.0), "timeout")
		if distance < 2:
			get_node("GreenLights").visible = true
			yield(get_tree().create_timer(3.0), "timeout")
			get_node("SuccessPanel").visible = true
			success.play("success")
		else:
			get_node("RedLights").visible = true
			yield(get_tree().create_timer(3.0), "timeout")
			reset()
		
	if distance < 30:
		lift.near(true)
		mass.near(true)
	else:
		lift.near(false)
		mass.near(false)

func wind_tunnel():
	var deflect = Vector2()
	get_node("Wing").under_test = true
	camera.position = Vector2(640, 360)
	camera.set_zoom(zoom_out)
	fan.play("start")
	yield(get_tree().create_timer(1.0), "timeout")
	fan.play("loop")
	get_node("Wing/Sprite/Area2D").set_space_override_mode(3)
	get_node("Wing/Sprite/Area2D").set_linear_damp(10)
	if get_node("Wing").position.x - 640 < 0:
		deflect = Vector2(-0.5, 1)
	else:
		deflect = Vector2(0.5, 1)
	get_node("Wing/Sprite/Area2D").set_gravity_vector(deflect)
	yield(get_tree().create_timer(1.0), "timeout")
	get_node("Smoke_Dispenser").begin()

func reset():
	fan.stop()
	fan.play("start")
	fan.stop()
	camera.position = center.position
	camera.set_zoom(zoom_in)
	fan.frame = 0
	get_node("GreenLights").visible = false
	get_node("RedLights").visible = false
	get_node("Wing").under_test = false
	get_node("Wing/Sprite/Area2D").set_space_override_mode(0)
	get_node("Wing/Sprite/Area2D").set_linear_damp(0.1)
	get_node("Wing/Sprite/Area2D").set_gravity_vector(Vector2(0, 1))
	get_node("ButtonTest").disabled = false
