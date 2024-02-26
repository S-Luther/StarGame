extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var enneagramCombos = [
					[1,4,7],
					[1,7,4],
					[2,4,8],
					[2,8,4],
					[3,6,9],
					[3,9,6],
					[4,1,2],
					[4,2,1],
					[5,7,8],
					[5,8,7],
					[6,9,3],
					[6,3,9],
					[7,1,5],
					[7,5,1],
					[8,2,5],
					[8,5,2],
					[9,3,6],
					[9,6,3],
				  ];
var enneagramCompat = [
					[1,2,9],
					[2,4,8],
					[3,1,9],
					[4,2,9],
					[5,1],
					[6,8,9,2],
					[7,5,1],
					[8,2,9],
					[9,4,6]
				  ];
var enneagramNonCompat = [
					[7],
					[],
					[],
					[8],
					[9],
					[],
					[],
					[4],
					[5]
				  ];


class Place:
	var name = "example"
	var est = 0
	var residents = []
	var services = []
	var value = 0
	var neighbors = []
	var popular = []
	var unpopular = []
	var visitors = []
	
	func _init():
		pass


class Person:
	var name = "example1"
	var age = 0
	var memories = []
	var thoughts = []
	var friends = []
	var enemies = []
	var family = []
	var knowledge = []
	var enneagram = [1,4,7]  
	var home = "This Base"
	var travels = ["homeworld", "This Base"]
	var icon = ""
	
	func _init():
		pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
