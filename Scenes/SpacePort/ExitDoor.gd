extends Area2D

signal leaving_level

func _on_ExitDoor_body_entered(body):
	if body is KinematicBody2D:
		if (!body.NPC):
			emit_signal("leaving_level")
