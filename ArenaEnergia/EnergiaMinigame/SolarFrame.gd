extends Position2D

func _ready():
	add_to_group("frames")

func occupied():
	remove_from_group("frames")
