extends Button

func _on_credits_mouse_entered():

	$creditos.modulate.g = 8

	$creditos.modulate.g = 8
	$creditos.modulate.g = 8
	pass # Replace with function body.
	
func _on_credits_mouse_exited():

	$creditos.modulate.g = 1

	$creditos.modulate.g = 1
	$creditos.modulate.g = 1
	pass # Replace with function body.
	
func _on_credits_pressed():

	$creditos.modulate.g = 0.8

	$creditos.modulate.g = 0.8
	$creditos.modulate.g = 0.8
	get_tree().change_scene("res://menu/credits.tscn")
	pass # Replace with function body.
