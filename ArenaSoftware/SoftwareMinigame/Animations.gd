extends Area2D

onready var failedAnimation_player = $FailedAnimation/AnimationPlayer
onready var passedAnimation_player = $PassedAnimation/AnimationPlayer

func which_one(iden):
	if iden == 0:
		get_node("FailedAnimation").modulate = Color.white
		failedAnimation_player.play("FailedAnim")
	elif iden == 1:
		get_node("FailedAnimation").modulate = Color.transparent
		passedAnimation_player.play("PassedAnim")
