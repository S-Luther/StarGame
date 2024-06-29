extends Node2D

const Player = preload("res://Scenes/Players/Player1.tscn")
const Exit = preload("res://Scenes/SpacePort/ExitDoor.tscn")
const NPCT = preload("res://Scenes/NPC/NPCTest.tscn")

var borders = Rect2(1, 1, 38, 21)
var NPC = false
var residents=[]

onready var tileMap = $TileMap
onready var spCam = $SpacePort2

onready var interactPanel = $SpacePort2/Panel
onready var interactSprite = $SpacePort2/Panel/Sprite
onready var interactLabel = $SpacePort2/Panel/ScrollContainer/Label


var player

func _ready():
	randomize()
	generate_level()
	self.position = Vector2(10000,10000)
	
func getRandomColor():
	var letters = '0123456789ABCDEF';
	var color = '#';
	for i in range(6):
		color += letters[randi()%12 + 4];
	return color;

func generate_level():
	player = Player.instance()
	add_child(player)
	player.add_to_group("SpacePortPlayer")
	
	player.position = Vector2(1212,497)
	player.scale = Vector2(2,2)
	
	for r in residents:
		var thing = NPCT.instance()
		thing.scale = Vector2(2,2)
		thing.service_ability = r.service_ability
		thing.position = Vector2(1200,700)
		thing.modulate = getRandomColor()
		thing.details = r

		self.add_child(thing)
		thing.add_to_group("people")
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = Vector2(1900, 1200)
	exit.scale - Vector2(1, .5)
	exit.connect("leaving_level", self, "reload_farm_level")
	


func reload_farm_level():
	if true:
		for p in get_tree().get_nodes_in_group("planets"):
			p.visible = true
		for p in get_tree().get_nodes_in_group("NavLines"):
			p.visible = true
		get_tree().get_nodes_in_group("cam")[0].current = true
		get_tree().get_nodes_in_group("World")[0].unpause();
		for p in get_tree().get_nodes_in_group("people"):
			p.queue_free()
		get_tree().get_root().remove_child(self)
	
func _physics_process(delta):
	spCam.position = player.position
	


func interact(r):
	r.generate_quest()
#	print(r.name)
	interactPanel.rect_size = Vector2(2,2)
	interactPanel.visible = true
	if r.avatar:
		interactSprite.frame = r.avatar
	interactLabel.text = "Name: " + String(r.name) + "\n" + "Age: " + String(r.age) + "\n" + "Culture: " + String(r.culture) + "\n" # + String(r.quests[0].locations_visited) + "\n" + String(r.quests[0].reward) + "\n"
	interactLabel.text += "Boredom: " + String(r.boredom) + "\n" + "Happiness: " + String(r.happiness) + "\n" + "Wealth: " + String(r.wealth) + "\n" + "Criminality: " + String(r.criminality) + "\n" + "Owner: " + String(r.business_owner) + "\n" + "Knowledge: \n"
	
	for t in r.skills:
		interactLabel.text += "  " + t + "\n"
		

	pass

