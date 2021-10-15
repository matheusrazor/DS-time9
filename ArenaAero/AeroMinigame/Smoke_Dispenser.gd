extends Node2D

var Smoke = load("res://ArenaAero/AeroMinigame/Smoke_Bullet.tscn")
var nozzles = []

func _ready():
	nozzles = get_tree().get_nodes_in_group("nozzles")
	
func begin():
	for x in range(15):
		for child in nozzles:
			var muzzle = child.global_position
			spawn(muzzle)
			yield(get_tree().create_timer(0.02), "timeout")

func spawn(nozzle):
	var b = Smoke.instance()
	b.global_position = nozzle
	owner.add_child(b)
