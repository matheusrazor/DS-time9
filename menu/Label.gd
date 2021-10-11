extends Label

var drawTextSpeed: int = 0
#the speed at which the text is drawn

var chatterLimit: int = 1500


func _showChatter():
	if drawTextSpeed < chatterLimit:
		drawTextSpeed += 1
		self.visible_characters = drawTextSpeed

	if drawTextSpeed == chatterLimit:
		get_tree().change_scene("res://menu/menu.tscn")

	
func _process(delta):
	_showChatter()
	pass
