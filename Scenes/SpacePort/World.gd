extends Node2D

const Player = preload("res://Scenes/Players/Player1.tscn")
const Exit = preload("res://Scenes/SpacePort/ExitDoor.tscn")
const NPCT = preload("res://Scenes/NPC/NPCTest.tscn")

var borders = Rect2(1, 1, 38, 21)
var NPC = false

onready var tileMap = $TileMap
onready var spCam = $SpacePort

onready var interactPanel = $SpacePort/Panel
onready var interactSprite = $SpacePort/Panel/Sprite
onready var interactLabel = $SpacePort/Panel/ScrollContainer/Label

onready var C1 = $ColorRect
onready var C2 = $ColorRect2
onready var C3 = $ColorRect3
onready var C4 = $ColorRect4

onready var Mush = $Mushrooms
onready var Mush1 = $Mushrooms/Sprite4
onready var Mush2 = $Mushrooms/Sprite5

onready var Exot = $Exotic
onready var Exot1 = $Exotic/Sprite4
onready var Exot2 = $Exotic/Sprite5

onready var Bulbs = $Bulbs
onready var Bulbs1 = $Bulbs/Sprite4
onready var Bulbs2 = $Bulbs/Sprite5

var player

func _ready():
	randomize()
	generate_level()
	
func getRandomColor():
	var letters = '0123456789ABCDEF';
	var color = '#';
	for i in range(6):
		color += letters[randi()%12 + 4];
	return color;

func generate_level():

	Bulbs.visible = false;
	Exot.visible = false;
	Mush.visible = false;
	player = Player.instance()
	add_child(player)
	player.add_to_group("SpacePortPlayer")
	
	player.position = Vector2(1800,1200)
	print(get_tree().get_nodes_in_group("World")[0].residents.size())
	
	if(get_tree().get_nodes_in_group("World")[0].culture == "A"):
		C1.color = "#915a5a"
		C2.color = "#915a5a"
		C3.color = "#915a5a"
		C4.color = "#915a5a"
		Bulbs.visible = true;
		Bulbs1.frame = randi() % 6
		Bulbs2.frame = randi() % 6
	elif(get_tree().get_nodes_in_group("World")[0].culture == "F"):
		C1.color = "#517e6a"
		C2.color = "#517e6a"
		C3.color = "#517e6a"
		C4.color = "#517e6a"
		Exot.visible = true;
		Exot1.frame = randi() % 6
		Exot2.frame = randi() % 6
	else:
		C1.color = "#a58153"
		C2.color = "#a58153"
		C3.color = "#a58153"
		C4.color = "#a58153"
		Mush.visible = true;
		Mush1.frame = randi() % 6
		Mush1.frame = randi() % 6
		
	for r in get_tree().get_nodes_in_group("World")[0].residents:
		var thing = NPCT.instance()
		thing.position = player.position + Vector2(-randi() % 1800, -randi() % 1100)
		thing.modulate = getRandomColor()
		thing.details = r

		self.add_child(thing)
		thing.add_to_group("people")
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = Vector2(1900, 1200)
	exit.connect("leaving_level", self, "reload_level")
	


func reload_level():
	get_tree().get_nodes_in_group("cam")[0].current = true
	get_tree().get_nodes_in_group("World")[0].unpause();
	for p in get_tree().get_nodes_in_group("people"):
		p.queue_free()
	get_tree().get_root().remove_child(self)
	
func _process(delta):
	spCam.position = player.position
	


func interact(r):
	print(r.name)
	interactPanel.visible = true
	if r.avatar:
		interactSprite.frame = r.avatar
	interactLabel.text = "Name: " + String(r.name) + "\n" + "Age: " + String(r.age) + "\n" + "Culture: " + String(r.culture) + "\n"
	interactLabel.text += "Boredom: " + String(r.boredom) + "\n" + "Happiness: " + String(r.happiness) + "\n" + "Knowledge: \n"
	
	for t in r.skills:
		interactLabel.text += "  " + t + "\n"
		

	pass

