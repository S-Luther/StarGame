extends "res://Scripts/LancerDrone.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var nodes
var merchandise = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	nodes = get_tree().get_nodes_in_group("planets")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for n in nodes:
		
		if self.position.distance_to(n.position) < 4000:
			if n is Farm:
				self.merchandise = self.merchandise + n.produce
#				print("picked up ", n.produce)
				n.produce = 0
			else:
				n.node.value = n.node.value + self.merchandise
#				print("dropped off ", self.merchandise)
				self.merchandise = 0
				

