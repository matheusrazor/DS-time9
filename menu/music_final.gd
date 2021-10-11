extends AudioStreamPlayer

func _on_music_final_finished():
	get_tree().change_scene("res://menu/menu.tscn")
	pass 
