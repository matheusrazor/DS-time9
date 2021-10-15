extends Node2D

onready var bar_1 = $EnergyBar_1/AnimationPlayer
onready var bar_2 = $EnergyBar_2/AnimationPlayer
onready var bar_3 = $EnergyBar_3/AnimationPlayer
onready var bar_4 = $EnergyBar_4/AnimationPlayer
onready var bar_5 = $EnergyBar_5/AnimationPlayer

onready var success = $SuccessPanel

func _ready():
	get_node("EnergyBar_2").modulate = Color.transparent
	get_node("EnergyBar_3").modulate = Color.transparent
	get_node("EnergyBar_4").modulate = Color.transparent
	get_node("EnergyBar_5").modulate = Color.transparent
	bar_1.play("bar1")

var count = 1

func progress_bar():
	count += 1
	if count == 2:
		bar_1.stop()
		get_node("EnergyBar_2").modulate = Color.white
		bar_2.play("bar2")
	if count == 3:
		bar_2.stop()
		get_node("EnergyBar_3").modulate = Color.white
		bar_3.play("bar3")
	if count == 4:
		bar_3.stop()
		get_node("EnergyBar_4").modulate = Color.white
		bar_4.play("bar4")
	if count == 5:
		bar_4.stop()
		get_node("EnergyBar_5").modulate = Color.white
		bar_5.play("bar5")

func _process(delta):
	if count == 5:
		yield(get_tree().create_timer(3.0), "timeout")
		get_node("SuccessPanel").visible = true
		success.play("success")
