extends Node2D

const Player = preload("res://Scenes/Players/Player1.tscn")
const Exit = preload("res://Scenes/SpacePort/ExitDoor.tscn")
const NPCT = preload("res://Scenes/NPC/NPCTest.tscn")

const Bank = preload("res://Scenes/SpacePort/Rooms/Bank.tscn")
const Data = preload("res://Scenes/SpacePort/Rooms/Data.tscn")
const Food = preload("res://Scenes/SpacePort/Rooms/DiningHall.tscn")
const Distillary = preload("res://Scenes/SpacePort/Rooms/Distillery.tscn")
const Furnace = preload("res://Scenes/SpacePort/Rooms/Furnace.tscn")
const Hospital = preload("res://Scenes/SpacePort/Rooms/Hospital.tscn")
const Mechanic = preload("res://Scenes/SpacePort/Rooms/Mechanic.tscn")
const Mining = preload("res://Scenes/SpacePort/Rooms/Miner.tscn")
const Police = preload("res://Scenes/SpacePort/Rooms/Police.tscn")
const Shipping = preload("res://Scenes/SpacePort/Rooms/Shipping.tscn")
const Shipyard = preload("res://Scenes/SpacePort/Rooms/ShipYard.tscn")
const Theatre = preload("res://Scenes/SpacePort/Rooms/Theatre.tscn")

var Tops = ["Mining", "Mechanic"]
var TopSpots = [Vector2(1486, 66),Vector2(915, 66),Vector2(1486340, 66)]
var Verts = ["Bank", "Food", "Distillary", "Furnace", "Theatre"]
var VertSpots = [Vector2(1909, 430),Vector2(1627, 430),Vector2(1342, 430),Vector2(486, 430),Vector2(195, 430)]
var Bottoms = ["Data", "Hospital", "Police", "Shipping", "Shipyard"]
var BottomSpots = [Vector2(340, 1140),Vector2(340, 820),Vector2(1486, 1140),Vector2(1486, 820)]

var services_reference = [
				"Food",
				"Data",
				"Mining",
				"Mechanic",
				"Shipyard",  
				"Furnace",
				"Distillary",
				"Hospital",
				"Police",
				"Bank",
				"Shipping",
				"Theatre"
			]

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
	
	var services = get_tree().get_nodes_in_group("World")[0].services
	var ser = []
	
	var VertSpotsCopy = VertSpots.duplicate()
	
	for b in BottomSpots:
		if services.has("Hospital"):
			var space = Hospital.instance()
			space.position = b
			add_child(space)
			services.erase("Hospital")

			continue
		if services.has("Police"):
			var space = Police.instance()
			space.position = b
			add_child(space)
			services.erase("Police")

			continue
		if services.has("Data"):
			var space = Data.instance()
			space.position = b
			add_child(space)
			services.erase("Data")

			continue
		if services.has("Shipping"):
			var space = Shipping.instance()
			space.position = b
			add_child(space)
			services.erase("Shipping")

			continue
		if services.has("Shipyard"):
			var space = Shipyard.instance()
			space.position = b
			add_child(space)
			services.erase("Shipyard")

			continue
		
	for b in VertSpots:
		if services.has("Bank"):
			var space = Bank.instance()
			space.position = b
			add_child(space)
			services.erase("Bank")
			VertSpotsCopy.erase(b)
			continue
		if services.has("Food"):
			var space = Food.instance()
			space.position = b
			add_child(space)
			services.erase("Food")
			VertSpotsCopy.erase(b)
			continue
		if services.has("Distillary"):
			var space = Distillary.instance()
			space.position = b
			add_child(space)
			services.erase("Distillary")
			VertSpotsCopy.erase(b)
			continue
		if services.has("Furnace"):
			var space = Furnace.instance()
			space.position = b
			add_child(space)
			services.erase("Furnace")
			VertSpotsCopy.erase(b)
			continue
		if services.has("Theatre"):
			var space = Theatre.instance()
			space.position = b
			add_child(space)
			services.erase("Theatre")
			VertSpotsCopy.erase(b)
			continue
			
	for b in TopSpots:
		if services.has("Mining"):
			var space = Mining.instance()
			space.position = b
			add_child(space)
			services.erase("Mining")

			continue
		if services.has("Mechanic"):
			var space = Mechanic.instance()
			space.position = b
			add_child(space)
			services.erase("Mechanic")

			continue
		if services.has("Data"):
			var space = Data.instance()
			space.position = b
			add_child(space)
			services.erase("Data")

			continue
		if services.has("Shipping"):
			var space = Shipping.instance()
			space.position = b
			add_child(space)
			services.erase("Shipping")

			continue
		if services.has("Shipyard"):
			var space = Shipyard.instance()
			space.position = b
			add_child(space)
			services.erase("Shipyard")

			continue
		if services.has("Police"):
			var space = Police.instance()
			space.position = b
			add_child(space)
			services.erase("Police")
			continue
	if VertSpotsCopy.size() >= 2:
		if services.has("Shipyard"):
			var space = Shipyard.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Shipyard")
			
		elif services.has("Police"):
			var space = Police.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Police")
		
		elif services.has("Hospital"):
			var space = Hospital.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Hospital")
			
		elif services.has("Data"):
			var space = Data.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Data")

			
		elif services.has("Shipping"):
			var space = Shipping.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Shipping")



			


			
		
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

