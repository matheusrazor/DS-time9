extends CanvasLayer

const char_read_rate = 0.05
onready var textbox_conatiner = $MarginContainer
onready var start_symbol = $MarginContainer/Panel/HBoxContainer/Label/Start
onready var end_symbol = $MarginContainer/Panel/HBoxContainer/End
onready var label = $MarginContainer/Panel/HBoxContainer/Label
var current_state = State.ready
var text_queue = []

enum State{
	ready,
	reading,
	finished
}

func _ready():
	print("Starting state: State.ready")
	hide_texbox()

	text_queue("Nossa! Eu vim saltitando quando vi o acidente, fez um baita barulho! Voce esta bem?")
	text_queue("Eu vi partes voando para todos os lados, infelizmente... Seria impossivel pra voce achar todas sozinho.")
	text_queue("A floresta das engenharias e bem grande... e voce tem que tomar certos cuidados...")
	text_queue("Para sua sorte eu conheço muito bem essa floresta, posso te ajudar! Ergh... se voce quiser, claro.")
	text_queue("Eu vi uma das partes voando por aquele caminho ali, que da na arena de software.")
	text_queue("Aqui nessa floresta se encontram 5 arenas, de 5 engenharias diferentes: Engenharias de Software, Eletronica, Energia, Automotiva e Aeroespacial.")
	text_queue("Acho que vai ter de visitar todas atras das partes do seu carro... Bom, boa sorte, a gente se encontra por ai!")
	
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
				change_state(State.ready)
				hide_texbox()
				
func text_queue(next_text):
	text_queue.push_back(next_text)
	
func hide_texbox():
	start_symbol = ""
	end_symbol.text = "Next"
	label.text = ""
	textbox_conatiner.hide()
	
func show_textbox():
	start_symbol = ""
	textbox_conatiner.show()
	
func add_text():
	var next_text = text_queue.pop_front()
	label.text = next_text
	label.percent_visible = 0.0
	change_state(State.reading)
	show_textbox()
	$Tween.interpolate_property(label, "percent_visible", 0.0, 1.0, len(next_text)*char_read_rate, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	$Tween.start()
	
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

