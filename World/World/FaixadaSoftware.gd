extends Area2D

export(String, FILE, "*.tscn") var ArenaSoftware

func _on_FaixadaSoftware_body_entered(body):
	get_tree().change_scene(ArenaSoftware)
