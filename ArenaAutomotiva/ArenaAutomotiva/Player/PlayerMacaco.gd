extends KinematicBody2D

const aceleracao = 500
const max_Aceleracao = 80
const friccao = 500

var velocidade = Vector2.ZERO

onready var animacaoPlayer = $AnimationPlayer
onready var animacaoTree = $AnimationTree
onready var animacaoEstado = animacaoTree.get("parameters/playback")

func _physics_process(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	
	if input_vector != Vector2.ZERO:
		animacaoTree.set("parameters/Idle/blend_position", input_vector)
		animacaoTree.set("parameters/Anda/blend_position", input_vector)
		animacaoEstado.travel("Anda")
		velocidade = velocidade.move_toward(input_vector * max_Aceleracao, aceleracao * delta)
	else:
		animacaoEstado.travel("Idle")
		velocidade = velocidade.move_toward(Vector2.ZERO, friccao * delta)
		
	velocidade = move_and_slide(velocidade)
		
