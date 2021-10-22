extends Area2D

var interativo = false
const dialog = preload("res://CaixasDeTexto/chitchat_rabbit.tscn")

func _on_Pc1_body_entered(body):
	if body.name == "Player":
		$Label.visible = true
		interativo = true


func _on_MinijogoSoftware_body_exited(body):
	if body.name == "Player":
		$Label.visible = false
		interativo = false


func _input(event):
	if Input.is_key_pressed(KEY_E) and interativo == true:
		$Label.visible = false
		var dialogo = dialog.instance()
		get_parent().add_child(dialogo)
