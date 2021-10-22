extends CanvasLayer

const char_read_rate = 0.05
onready var textbox_conatiner = $MarginContainer
onready var start_symbol = $MarginContainer/Panel/HBoxContainer/Label/Start
onready var end_symbol = $MarginContainer/Panel/HBoxContainer/End
onready var label = $MarginContainer/Panel/HBoxContainer/Label
var current_state = State.ready
var icon1 = preload("res://CaixasDeTexto/catHead.png")
var icon2 = preload("res://CaixasDeTexto/playerHead.png")
var text_queue = []
var icon_queue = []

enum State{
	ready,
	reading,
	finished
}

# gato = 1 , macaco = 2.
func _ready():
	print("Starting state: State.ready")
	hide_icon1()
	hide_icon2()
	hide_texbox()
	text_queue("Ergh... Licença... Eu sou o Macaco e...", 2)
	text_queue("AI! QUE SUSTO! Desculpa Macaco, em baixo do carro não da pra ver nada! Sou o Gato, tudo bem? Bem vindo à Engrena!", 1)
	text_queue("Obrigado mas... esse é o meu carro, Gato! Eu estava voando por cima dessa floresta e o motor dele parou e fez esse estrago", 2)
	text_queue("Caramba, ainda bem que chegou a tempo, eu ia começar a desmontar ele pra por as peças no meu carrão vermelho!", 1)
	text_queue("Desculpa por isso, achei que não tinha dono, e eu vi o turbo desse carro e fiquei maluco!", 1)
	text_queue("É um turbo muitoo bom mesmo, ajuda o carro a ter força para voar!", 2)
	text_queue("Ergh... sobre isso... Eu vi as assas do seu carro, mas como eu não iria usar, entreguei pro Porco...", 1)
	text_queue("Desculpa mais uma vez por esse mal-entendido!", 1)
	text_queue("Tudo bem, Gato! Não tinha como você saber que era meu...", 2)
	text_queue("Mas oh, que tal eu arrumar ele pra você? Como uma forma de me desculpar pelo transtorno!", 1)
	text_queue("Não precisa se desculpar, mas eu adoraria a ajuda!", 2)
	text_queue("Tranquilo... Vai demorar um pouco, então dá uma volta na arena e depois pega a gasolina para a gente testar", 1)
	text_queue("Beleza!", 2)

	
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
	get_node("MarginContainer/catHead").hide()

func hide_icon2():
	start_symbol = ""
	end_symbol.text = "Next"
	label.text = ""
	get_node("MarginContainer/playerHead").hide()
	
func show_textbox():
	start_symbol = ""
	textbox_conatiner.show()
	
func show_icon1():
	start_symbol = ""
	get_node("MarginContainer/catHead").show()
	
func show_icon2():
	start_symbol = ""
	get_node("MarginContainer/playerHead").show()
	
	
func add_text():
	var next_text = text_queue[0]['msg']
	var next_icon = text_queue[0]['autor']
	if next_icon == 1:
		show_icon1()
	elif next_icon == 2:
		show_icon2()
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

