extends Area2D

var interativo = false
const dialog = preload("res://CaixasDeTexto/Chitchat.tscn")

func _on_CarSideBroken_body_exited(body):
	if body.name == "Player":
		$Carrinho.visible = false
		interativo = false


func _on_CarSideBroken_body_entered(body):
	if body.name == "Player":
		$Carrinho.visible = true
		interativo = true

func _input(event):
	if Input.is_key_pressed(KEY_E) and interativo == true:
		$Carrinho.visible = false
		var dialogo = dialog.instance()
		get_parent().add_child(dialogo)
