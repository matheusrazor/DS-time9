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
	text_queue("Viu Bode? Eu consegui!", 2)
	text_queue("Hmmm... Isso é sorte! Mas ok,você também é bem inteligente...", 1)
	text_queue("Muito Obrigado, agora vou pegar a minha peça na sala!", 2)
	text_queue("Óbivo que não! Só entra naquela sala pessoas SUPER inteligentes: Engenheiros Eeletrônicos", 1)
	text_queue("Como eu sou SUPER inteligente e um engenheiro eletrônico, eu entrei e peguei pra você.", 1)
	text_queue("Aqui, essa é sua peça, a tal bateria do seu carro", 1)
	text_queue("*Peça bateria para o carro entregue*", 0)
	text_queue("Mas tem algo que eu preciso dizer... Talvez eu usei a bateria demais e ela não esteja mais carregada...", 1)
	text_queue("Ah não! E agora? Como vou fazer para carregar minha bateria?", 2)
	text_queue("Para tudo eu tenho uma solução, eu sou um bode muito velho que...", 1)
	text_queue("Já subiu muitas montanhas, eu já sei, Bode! Mas qual a solução?", 2)
	text_queue("Se você seguir pela estrada da floretsa, vai chegar na arena de Energia.", 1)
	text_queue("Lá a Galinha pode te ajudar, pede para ela carregar sua bateria para você!", 1)
	text_queue("Diga que o Bode mandou abraços! Somos velhos amigos!", 1)
	text_queue("Obrigado Bode! Vou até lá agora! Até mais!", 2)
	text_queue("Tchau, Macaco! E ah... Você levou jeito com o protoboard... pense sobre a Engenhaia Eletrônica!", 1)
	text_queue("Pode deixar, Bode!", 2)

	
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

