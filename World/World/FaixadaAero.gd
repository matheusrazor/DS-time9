extends Area2D

export(String, FILE, "*.tscn") var ArenaAero

func _on_FaixadaAero_body_entered(body):
	get_tree().change_scene(ArenaAero)
