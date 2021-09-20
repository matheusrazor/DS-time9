extends AudioStreamPlayer

var this

export (bool) var loop_sound = true
func _ready():
	connect("finished", this, "_on_finished")
func _on_finished():
	if loop_sound == true:
		play();
