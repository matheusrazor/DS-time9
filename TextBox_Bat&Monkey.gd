extends CanvasLayer

const char_read_rate = 0.05
onready var textbox_conatiner = $MarginContainer
onready var start_symbol = $MarginContainer/Panel/HBoxContainer/Label/Start
onready var end_symbol = $MarginContainer/Panel/HBoxContainer/End
onready var label = $MarginContainer/Panel/HBoxContainer/Label
var current_state = State.ready
var icon1 = preload("res://CaixasDeTexto/batHead.png")
var icon2 = preload("res://CaixasDeTexto/playerHead.png")
var text_queue = []
var icon_queue = []

enum State{
	ready,
	reading,
	finished
}

# morcego = 1 , macaco = 2.
func _ready():
	print("Starting state: State.ready")
	hide_icon1()
	hide_icon2()
	hide_texbox()
	text_queue("Olá, estou procurando por uma peça do meu carro, que parou de funcionar e esta todo quebrado... ", 2)
	text_queue("Ela parece um pequeno computador e o Coelho me disse que veio por aqui.", 2)
	text_queue("Ah sim... eu vi uma parte como essa voar para dentro dessa sala, aliás, Bem vindo à Orc'estra!",1)
	text_queue("Muito obrigado, vou buscar!", 2)
	text_queue("Espera, espera, espera! Eu nao posso, de jeito nenhum, deixar você entrar aqui!", 1)
	text_queue("Essa sala é exclusiva para os alunos de software!", 1)
	text_queue("Poxa! Mas eu preciso muito dela! Se não como vou fazer meu carro voar de novo?", 2)
	text_queue("Bom... Hm... Eu posso te ajudar se voce me ajudar, o que acha?", 1)
	text_queue("??", 2)
	text_queue("Estou tendo um problema com o meu código, um erro de compilação maligno tomou conta dele!", 1)
	text_queue("Me ajude a resolver esse problema e eu abro a porta para voce, ok?", 1)
	text_queue("Ok... Interessante...", 2)
	text_queue("Ande pela sala, talvez você encontre dicas para consguir resolver o erro!", 1)

	
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
	get_node("MarginContainer/batHead").hide()

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
	get_node("MarginContainer/batHead").show()
	
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
