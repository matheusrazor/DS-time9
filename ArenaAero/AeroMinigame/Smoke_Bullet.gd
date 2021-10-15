extends RigidBody2D

var speed = 100

func _physics_process(delta):
	position += transform.y * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
