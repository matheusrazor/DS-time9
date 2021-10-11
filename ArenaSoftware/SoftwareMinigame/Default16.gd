extends Position2D

var nonvacant = false

func _draw():
	draw_rect(Rect2(0,0,14,5), Color.transparent, false, 13, false)
	
func select():
	for child in get_tree().get_nodes_in_group("default16"):
		child.deselect()
	modulate = Color.white
	nonvacant = true

func deselect():
	modulate = Color.white
	nonvacant = false
	
func is_vacant():
	if nonvacant:
		return false
	else:
		return true
