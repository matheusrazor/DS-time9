extends Position2D

func _draw():
	draw_rect(Rect2(0,0,14,5), Color.transparent, false, 30, false)
	
func select():
	for child in get_tree().get_nodes_in_group("default48"):
		child.deselect()
	modulate = Color.white

func deselect():
	modulate = Color.white
