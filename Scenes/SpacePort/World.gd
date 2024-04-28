extends Node2D

const Player = preload("res://Scenes/Players/Player1.tscn")
const Exit = preload("res://Scenes/SpacePort/ExitDoor.tscn")
const NPC = preload("res://Scenes/NPC/NPCTest.tscn")

var borders = Rect2(1, 1, 38, 21)

onready var tileMap = $TileMap
onready var spCam = $SpacePort

onready var interactPanel = $SpacePort/Panel
onready var interactSprite = $SpacePort/Panel/Sprite
onready var interactLabel = $SpacePort/Panel/ScrollContainer/Label

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

	
	player = Player.instance()
	add_child(player)
	
	player.position = Vector2(1800,1200)
	print(get_tree().get_nodes_in_group("World")[0].residents.size())
	for r in get_tree().get_nodes_in_group("World")[0].residents:
		var thing = NPC.instance()
		thing.position = player.position + Vector2(-randi() % 1800, -randi() % 1100)
		thing.modulate = getRandomColor()
		thing.details = r

		self.add_child(thing)
		thing.add_to_group("people")
		var label = Label.new();
		
		label.set_position(thing.position + Vector2(-20, -20))
		label.rect_scale = Vector2(2,2)
		label.text = r.name
		self.add_child(label)
		label.add_to_group("people")
	
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
	
	for t in r.knowledge:
		interactLabel.text += "  " + t + "\n"
		

	pass

