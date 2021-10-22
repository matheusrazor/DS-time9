extends Area2D

export(String, FILE, "*.tscn") var ArenaEnergia

func _on_FaixadaEnergia_body_entered(body):
	get_tree().change_scene(ArenaEnergia)
