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
	text_queue("Terminei por aqui, Galinha!", 2)
	text_queue("Muito bem Macaco! Você fez tudo tão rápido... Por acaso é Engenheiro de Energia?", 1)
	text_queue("Não, hahaha! Só gostei muito de arrumar as placas solares!", 2)
	text_queue("Fico triste por você não ser Engenheiro de Energia...", 1)
	text_queue("Porque agora não vou poder mostrar pra você a sala especial de energia, lá só entra quem sabe muito de energia!", 1)
	text_queue("Mas aqui está sua bateria!", 1)
	text_queue("*bateria do carro entregue*", 0)
	text_queue("Poxa fico triste de não poder conhecer a sala especial de energia...", 2)
	text_queue("Mas estou muito feliz com a bateria carregada! Muito obrigada, Galinha, me salvou!", 2)
	text_queue("Quase ia me esquecendo, o Coelho me ligou e me disse que viu o Gato levando o seu carro para a oficina dele!", 1)
	text_queue("Mas o carro é meu!", 2)
	text_queue("A Arena de Automotiva é aqui do lado, vai rápido porque... ", 1)
	text_queue("O Gato pega TUDO QUE PODE dessa floresta pra por naquele carro vermelho dele!", 1)
	text_queue("Caramba! Estou indo agora mesmo! Obrigada por tudo, Galinha!", 2)
	text_queue("Adeus, Macaco! Muito Obrigada pela ajuda!", 1)

	
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
