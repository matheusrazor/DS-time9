extends CanvasLayer

const char_read_rate = 0.05
onready var textbox_conatiner = $MarginContainer
onready var start_symbol = $MarginContainer/Panel/HBoxContainer/Label/Start
onready var end_symbol = $MarginContainer/Panel/HBoxContainer/End
onready var label = $MarginContainer/Panel/HBoxContainer/Label
var current_state = State.ready
var icon1 = preload("res://CaixasDeTexto/chickenHead.png")
var icon2 = preload("res://CaixasDeTexto/playerHead.png")
var text_queue = []
var icon_queue = []

enum State{
	ready,
	reading,
	finished
}

# galinha = 1 , macaco = 2.
func _ready():
	print("Starting state: State.ready")
	hide_icon1()
	hide_icon2()
	hide_texbox()
	text_queue("Oi Galinha tudo bem? Eu sou o Macaco!", 2)
	text_queue("Olá Macaco! Uma pergunta: Como nunca te vi aqui na floresta?", 1)
	text_queue("Infelizmente meu carro quebrou, e eu estou atrá das suas peças pela floresta!", 2)
	text_queue("O Bode me falou sobre a senhorita, disse que podeira me ajudar num problema com a minha bateria... Você pode me ajudar?", 2)
	text_queue("Qualquer amigo do Bode, é meu amigo! Bem vindo à Matriz! Claro que ajudo! Do que está precisando?", 1)
	text_queue("Essa Bateria aqui, ela esta sem energia... Teria como carregar ela pra mim, por favor? Se não, não volto para casa!", 2)
	text_queue("*bateria do carro entregue para Galinha*", 0)
	text_queue("Energia é comigo mesmo! Me dê alguns minutos! Vou pecisar entrar na sala especial de energia para isso...", 1)
	text_queue("Será que você pode me ajudar enquanto arrumo sua bateria?", 1)
	text_queue("Claro Galinha, no que posso ajudar?", 2)
	text_queue("Eu estava ajeitando as placas solares para conseguir mais energia limpa para a Arena de Energia, mas não consegui terminar", 1)
	text_queue("Será que você pode terminar pra mim? Não é nada muito difícil, mas da uma volta aqui na arena para encontrar dicas", 1)
	text_queue("Estou indo agora!", 2)

	
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
	get_node("MarginContainer/chickenHead").hide()

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
	get_node("MarginContainer/chickenHead").show()
	
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

