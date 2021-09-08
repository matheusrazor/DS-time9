extends Label

var drawTextSpeed: int = 0
#the speed at which the text is drawn
var chatterLimit: int = 568

func _showChatter():
	if drawTextSpeed < chatterLimit:
		drawTextSpeed += 1
		self.visible_characters = drawTextSpeed
	pass
	
func _process(delta):
	_showChatter()
	pass
