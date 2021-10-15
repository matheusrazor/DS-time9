extends Node2D

onready var success = $SuccessPanel

var parked = false

func _ready():
	get_node("Parking_Spot/whiteSpot").modulate = Color.transparent

func _on_Parking_Spot_body_entered(body):
	get_node("Parking_Spot/whiteSpot").modulate = Color.white
	get_node("Label").visible = true
	parked = true

func _on_Parking_Spot_body_exited(body):
	get_node("Parking_Spot/whiteSpot").modulate = Color.transparent
	get_node("Label").visible = false
	parked = false
	
func _input(event):
	if event is InputEventKey:
		if event.scancode == KEY_E and event.pressed and parked:
			yield(get_tree().create_timer(1.0), "timeout")
			get_node("SuccessPanel").visible = true
			success.play("success")
