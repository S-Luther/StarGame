extends KinematicBody2D

var hasHappened = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	
func slice():
	pass
	
func hit():
	pass
#	if !get_tree().get_nodes_in_group("World")[0].paused:
#		hasHappened = true
#		var SpacePort = preload("res://Scenes/SpacePort/World.tscn").instance()
#		get_tree().get_root().add_child(SpacePort)
#		for p in get_tree().get_nodes_in_group("World"):
#			p.pause()
#			pass
#	#	get_tree().get_root().
#		get_tree().get_nodes_in_group("SpacePortCamera")[0].current = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
