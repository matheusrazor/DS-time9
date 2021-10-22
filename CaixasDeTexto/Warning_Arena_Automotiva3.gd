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
	text_queue("Combustíveis são as substâncias químicas que, ao reagirem com o oxigênio, sofrem um fenômeno químico denominado de...")
	text_queue("Combustão! Liberando certa quantidade de energia na forma de calor. Existem tipos de combustíveis:")
	text_queue("Renovável ou não fóssil: Combustível que pode ser obtido a partir de fontes naturais: Água, Etanol e Biodiesel")
	text_queue("Não renovável ou Fóssil: Combustível que é obtido a partir de fontes que foram formadas durante milhões de anos...")
	text_queue("Essas fontes, todavia, não podem ser repostas em virtude do tempo necessário para a sua formação: Gasolina e Óleo diesel.")
	
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
