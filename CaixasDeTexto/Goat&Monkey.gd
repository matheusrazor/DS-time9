extends CanvasLayer

const char_read_rate = 0.05
onready var textbox_conatiner = $MarginContainer
onready var start_symbol = $MarginContainer/Panel/HBoxContainer/Label/Start
onready var end_symbol = $MarginContainer/Panel/HBoxContainer/End
onready var label = $MarginContainer/Panel/HBoxContainer/Label
var current_state = State.ready
var icon1 = preload("res://CaixasDeTexto/goatHead.png")
var icon2 = preload("res://CaixasDeTexto/playerHead.png")
var text_queue = []
var icon_queue = []

enum State{
	ready,
	reading,
	finished
}

# cabra = 1 , macaco = 2.
func _ready():
	print("Starting state: State.ready")
	hide_icon1()
	hide_icon2()
	hide_texbox()
	text_queue("O que é que você quer rondando a Eletronjun, a arena de eletrônica?", 1)
	text_queue("... ??", 2)
	text_queue("Eu estou falando com você mesmo, acha que eu tenho tempo pra ficar aq..", 1)
	text_queue("Calma Bode, eu vim atras de uma peça do meu carro, o Morcego disse que viu ela caindo por aqui, você a viu?", 2)
	text_queue("Esse Morcego é um linguarudo! Se a peça do carro que você esta falando é uma bateria", 1)
	text_queue("Ela caiu do céu pra mim, estava precisando de uma! ", 1)
	text_queue("Com ela meu protoboard voltou a funcionar e assim eu posso continuar construindo meus eletrônicos.", 1)
	text_queue("Mas bode, isso faz parte do MEU carro... Caiu do céu porque a queda foi feia... Eu REALMENTE preciso dela!", 2)
	text_queue("Hmm, vem só para encher minha paciência!", 1)
	text_queue("Têm um circuito que eu nunca, nunca na minha vida, consegui arrumar... e olha que eu sou MUITO inteligente!", 1)
	text_queue("Sou um bode velho, muito inteligente que passou a vida subindo montanhas, e conto mais...", 1)
	text_queue("OK BODE... me diz o que eu preciso fazer, e eu faço!", 2)
	text_queue("No protoboard, ajeite aquele cirucito para ele funcionar, se ele funcionar, te devolvo a bateria!", 1)
	text_queue("Ande por ai, talvez encontre dicas...", 1)
	text_queue("Entendi! Vou te mostar, Bode, que eu também sou inteligente como o senhor!", 2)

	
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
	get_node("MarginContainer/goatHead").hide()

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
	get_node("MarginContainer/goatHead").show()
	
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

