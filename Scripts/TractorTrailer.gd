extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
	

var trailer = true
var rot_delta = 0.0
var rot_prev = 0.0
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var parent = self.get_parent()
#	print(rot_delta)
#	print(parent.rotation, " ",  rot_prev)
	rot_delta =  parent.rotation - rot_prev
	if(abs(rot_delta) > .5):
		print(rot_delta)
	else:
		if parent.trailer:
			self.rotation = parent.rotation
		else:
			self.rotation = lerp(self.rotation, -rot_delta*50, 0.005)
#		if parent.rotation > 0:
#			self.rotation = lerp(self.rotation, rot_delta*200, .001)
#		else:
#			self.rotation = lerp(self.rotation, -rot_delta*200, .001)
#	else:
#		if parent.rotation > 0:
#			self.rotation = lerp(self.rotation, -rot_delta*200, .001)
#		else:
#			self.rotation = lerp(self.rotation, rot_delta*200, .001)
		
	rot_prev = parent.rotation

func hit():
	pass
	
func slice():
	pass
