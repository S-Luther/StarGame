extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var origin = null
var destination = null
var childs = self.get_children()
# Called when the node enters the scene tree for the first time.
func _ready():
	childs = self.get_children()

func _process(delta):
	childs = self.get_children()
	if origin != null && childs[0].origin == null:
		for c in childs:
			c.origin = origin
			c.pre_target = destination

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
