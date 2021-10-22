extends CanvasLayer

const char_read_rate = 0.05
onready var textbox_conatiner = $MarginContainer
onready var start_symbol = $MarginContainer/Panel/HBoxContainer/Label/Start
onready var end_symbol = $MarginContainer/Panel/HBoxContainer/End
onready var label = $MarginContainer/Panel/HBoxContainer/Label
var current_state = State.ready
var icon1 = preload("res://CaixasDeTexto/rabbitHead.png")
var icon2 = preload("res://CaixasDeTexto/playerHead.png")
var text_queue = []
var icon_queue = []

enum State{
	ready,
	reading,
	finished
}

# coelho = 1 , macaco = 2, aviso = 3.
func _ready():
	print("Starting state: State.ready")
	hide_icon1()
	hide_icon2()
	hide_icon3()
	hide_texbox()
	text_queue("Nossa! Eu vim saltitando quando vi o acidente, fez um baita barulho! Voce está bem??", 1)
	text_queue("Estou, mas meu carro não... Está todo quebrado, um caos!", 2)
	text_queue("Eu vi peças voando para todos os lados, infelizmente... Seria impossivel pra você achar todas sozinho.", 1)
	text_queue("A floresta das engenharias é bem grande... e você têm que tomar certos cuidados...", 1)
	text_queue("Bem grande? Cuidados? Oh não! O que eu posso fazer então??", 2)
	text_queue("Para sua sorte eu conheço muito bem essa floresta, posso te ajudar! Ergh... se você quiser, claro.", 1)
	text_queue("Caramba, eu adoraria! Muito obrigado, Coelho!", 2)
	text_queue("Eu vi uma das peças voando por aquele caminho alí, que dá na arena de software", 1)
	text_queue("Arena de software? Como assim?", 2)
	text_queue("Aqui nessa floresta se encontram 5 arenas, de 5 engenharias diferentes:", 1)
	text_queue("Engenharias de Software, Eletrônica, Energia, Automotiva e Aeroespacial", 1)
	text_queue("Acho que vai ter de visitar todas atrás das partes do seu carro... Bom, boa sorte, a gente se encontra por ai!", 1)
	text_queue("Isso vai ser uma grande aventura... Obrigado pelas dicas, Coelho, até mais", 2)
	text_queue("AVISO DO JOGO: Bem vindo ao “Eng Adventure”!", 3)
	text_queue("AVISO DO JOGO: Ajude o Macaco a montar o seu carro que quebrou, junte as peças que caíram nas arena de cada engenharia!", 3)
	text_queue("AVISO DO JOGO: Para conseguir pegar as peças, terá que ganhar os desafios enonctrados em cada arena!", 3)
	text_queue("AVISO DO JOGO: Objetivo: Vencer os desafios de cada arena para obter as peças do carro.", 3)
	text_queue("AVISO DO JOGO: Vamos começar! Vá até a arena de software, seguindo a estrada, para procurar por uma de suas peças.", 3)
	text_queue("AVISO DO JOGO: BOA SORTE!", 3)

	
func _process(delta):
	match current_state: 
		State.ready:
			if !text_queue.empty():
				add_text()
		State.reading:
			if Input.is_action_just_pressed("ui_accept"):
				label.percent_visible = 1.0
				$Tween.stop_all()
				end_symbol.text = "Next"
				change_state(State.finished)
		State.finished:
			if Input.is_action_just_pressed("ui_accept"):
				#var duda = sam.new("duda")
				change_state(State.ready)
				hide_texbox()
				hide_icon1()
				hide_icon2()
				
func text_queue(next_text, autor):
#	text_queue.push_back(next_text, autor)
	text_queue.append({"msg":next_text,"autor": autor})
	
func hide_texbox():
	start_symbol = ""
	end_symbol.text = "Next"
	label.text = ""
	textbox_conatiner.hide()
	
func hide_icon1():
	start_symbol = ""
	end_symbol.text = "Next"
	label.text = ""
	get_node("MarginContainer/rabbitHead").hide()

func hide_icon2():
	start_symbol = ""
	end_symbol.text = "Next"
	label.text = ""
	get_node("MarginContainer/playerHead").hide()
	
func hide_icon3():
	start_symbol = ""
	end_symbol.text = "Next"
	label.text = ""
	get_node("MarginContainer/warning").hide()
	
func show_textbox():
	start_symbol = ""
	textbox_conatiner.show()
	
func show_icon1():
	start_symbol = ""
	get_node("MarginContainer/rabbitHead").show()
	
func show_icon2():
	start_symbol = ""
	get_node("MarginContainer/playerHead").show()

func show_icon3():
	start_symbol = ""
	get_node("MarginContainer/warning").show()
	
func add_text():
	var next_text = text_queue[0]['msg']
	var next_icon = text_queue[0]['autor']
	if next_icon == 1:
		show_icon1()
	elif next_icon == 2:
		show_icon2()
	elif next_icon == 3:
		show_icon3()
	print(text_queue[0]['msg'], ">>>>>>>>>>>>>>>>>>>")
	label.text = next_text
	label.percent_visible = 0.0
	change_state(State.reading)
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text)*char_read_rate, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	text_queue.pop_front()
	
func _on_Tween_tween_all_completed():
	end_symbol.text = "Next"
	change_state(State.finished)

func change_state(next_state):
	current_state = next_state
	match current_state: 
		State.ready:
			print("Changing state to: State.ready")
		State.reading:
			print("Changing state to: State.reading")
		State.finished:
			print("Changing state to: State.finished")
