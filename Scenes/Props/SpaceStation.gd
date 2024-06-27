extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var hasHappened = false
var SpacePort = preload("res://Scenes/SpacePort/World.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func slice():
	pass

func hit():
	
	if !get_tree().get_nodes_in_group("World")[0].paused:
		hasHappened = true
		
		get_tree().get_root().add_child(SpacePort.instance())
		for p in get_tree().get_nodes_in_group("World"):
			p.pause()
	#	get_tree().get_root().
		get_tree().get_nodes_in_group("SpacePortCamera")[0].current = true
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_KinematicBody2D_area_entered(area):
	if !get_tree().get_nodes_in_group("World")[0].paused:
		hasHappened = true
		
		get_tree().get_root().add_child(SpacePort.instance())
		for p in get_tree().get_nodes_in_group("World"):
			p.pause()
	#	get_tree().get_root().
		get_tree().get_nodes_in_group("SpacePortCamera")[0].current = true
