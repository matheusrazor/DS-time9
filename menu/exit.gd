extends Button

func _on_exit_mouse_entered():
	$exit.modulate.g = 8
	$exit.modulate.g = 8
	$exit.modulate.g = 8
	pass # Replace with function body.

func _on_exit_mouse_exited():
	$exit.modulate.g = 1
	$exit.modulate.g = 1
	$exit.modulate.g = 1
	pass # Replace with function body.

func _on_exit_pressed():
	$exit.modulate.g = 0.8
	$exit.modulate.g = 0.8
	$exit.modulate.g = 0.8
	get_tree().change_scene("res://menu/menu.tscn")
	pass # Replace with function body.
