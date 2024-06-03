extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var origin = Vector2.ZERO
var destination = Vector2.ZERO
var childs = self.get_children()
# Called when the node enters the scene tree for the first time.
func _ready():
	pass

func _process(delta):
	childs = self.get_children()
	for c in childs:
		if c.origin != Vector2.ZERO:
			c.origin = origin
			c.pre_target = destination

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
