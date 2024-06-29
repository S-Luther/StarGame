extends Area2D

class_name Farm

var hasHappened = false
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var residents = []
var produce = 0
var runs = 0

var productivity = 0

var levels = [
				"Potential",
				"Novice",
				"Adequite",
				"Skilled",
				"Knowledgable",
				"Professional",
				"Master"
			]
			



var SpacePort = preload("res://Scenes/SpacePort/Farm.tscn")

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

var already_init = false

func _process(delta):
	if residents.size() > 0 && !already_init:
		for s in residents[0].skills:
			if s.find("Farmer") > -1:
				for l in levels.size():
					if s.find(levels[l]) > -1:
						productivity = productivity + l 
			
		already_init = true
		print("productivity: ", productivity)
	runs = runs + 1
	if runs % 10 == 0:
		produce = produce + (1 * productivity) + 1
	


func _on_Node2D_area_entered(area):
	if !get_tree().get_nodes_in_group("World")[0].paused:
		hasHappened = true
		var sp = SpacePort.instance()
		sp.z_index = 999999
		sp.residents = residents
		get_tree().get_root().add_child(sp)
		for p in get_tree().get_nodes_in_group("World"):
			p.pause()
		for p in get_tree().get_nodes_in_group("planets"):
			p.visible = false
		for p in get_tree().get_nodes_in_group("NavLines"):
			p.visible = false
	#	get_tree().get_root().
		get_tree().get_nodes_in_group("FarmCam")[0].current = true
