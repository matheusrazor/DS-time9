extends Node2D

func near(is_near):
	if is_near:
		modulate.a = 0.5
	else:
		modulate.a = 1
