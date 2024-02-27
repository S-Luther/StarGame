extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("tail")
	connect("body_entered", self, "_on_body_entered")
	
	pass # Replace with function body.

func _on_body_entered(other):
	if other is KinematicBody2D:
		other.slice()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
