extends Button

func _on_start_mouse_entered():
	$novo_jogo.modulate.g = 8
	$novo_jogo.modulate.g = 8
	$novo_jogo.modulate.g = 8
	pass # Replace with function body.

func _on_start_mouse_exited():
	$novo_jogo.modulate.g = 1
	$novo_jogo.modulate.g = 1
	$novo_jogo.modulate.g = 1
	pass # Replace with function body.

func _on_start_pressed():
	$novo_jogo.modulate.g = 0.8
	$novo_jogo.modulate.g = 0.8
	$novo_jogo.modulate.g = 0.8
	get_tree().change_scene("res://menu/intro_1.tscn")
	pass # Replace with function body.
