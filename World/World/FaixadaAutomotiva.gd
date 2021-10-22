extends Area2D

export(String, FILE, "*.tscn") var ArenaAutomotiva

func _on_FaixadaAutomotiva_body_entered(body):
	get_tree().change_scene(ArenaAutomotiva)
