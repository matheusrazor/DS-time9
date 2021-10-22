extends Area2D

export(String, FILE, "*.tscn") var ArenaEletronica

func _on_FaixadaEletrnica_body_entered(body):
	get_tree().change_scene(ArenaEletronica)
