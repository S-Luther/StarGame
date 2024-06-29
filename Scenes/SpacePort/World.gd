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
const Pillar = preload("res://Scenes/SpacePort/Rooms/Pillar.tscn")
const Empty = preload("res://Scenes/SpacePort/Rooms/Empty.tscn")

var Tops = ["Mining", "Mechanic"]
var TopSpots = [Vector2(1486, 66),Vector2(915, 66),Vector2(340, 66)]
var Verts = ["Bank", "Food", "Distillary", "Furnace", "Theatre"]
var VertSpots = [Vector2(1909, 430),Vector2(1627, 430),Vector2(1342, 430),Vector2(486, 430),Vector2(195, 430)]
var Bottoms = ["Data", "Hospital", "Police", "Shipping", "Shipyard"]
var BottomSpots = [Vector2(340, 820),Vector2(1486, 1140),Vector2(1486, 820),Vector2(340, 1140),Vector2(915,363)]

var shopSpots = []

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
#	self.position = Vector2(999999,999999)
	
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
	var TopSpotsCopy = TopSpots.duplicate()
	
	for b in BottomSpots:
		if services.has("Hospital"):
			shopSpots.append([services_reference.find("Hospital"), b])
			var space = Hospital.instance()
			space.position = b
			add_child(space)
			services.erase("Hospital")

			continue
		if services.has("Police"):
			shopSpots.append([services_reference.find("Police"), b])
			var space = Police.instance()
			space.position = b
			add_child(space)
			services.erase("Police")

			continue
		if services.has("Data"):
			shopSpots.append([services_reference.find("Data"), b])
			var space = Data.instance()
			space.position = b
			add_child(space)
			services.erase("Data")

			continue
		if services.has("Shipping"):
			shopSpots.append([services_reference.find("Shipping"), b])
			var space = Shipping.instance()
			space.position = b
			add_child(space)
			services.erase("Shipping")

			continue
		if services.has("Shipyard"):
			shopSpots.append([services_reference.find("Shipyard"), b])
			var space = Shipyard.instance()
			space.position = b
			add_child(space)
			services.erase("Shipyard")

			continue
		
	for b in VertSpots:
		if services.has("Bank"):
			shopSpots.append([services_reference.find("Bank"), b])
			var space = Bank.instance()
			space.position = b
			add_child(space)
			services.erase("Bank")
			VertSpotsCopy.erase(b)
			continue
		if services.has("Food"):
			shopSpots.append([services_reference.find("Food"), b])
			var space = Food.instance()
			space.position = b
			add_child(space)
			services.erase("Food")
			VertSpotsCopy.erase(b)
			continue
		if services.has("Distillary"):
			shopSpots.append([services_reference.find("Distillary"), b])
			var space = Distillary.instance()
			space.position = b
			add_child(space)
			services.erase("Distillary")
			VertSpotsCopy.erase(b)
			continue
		if services.has("Furnace"):
			shopSpots.append([services_reference.find("Furnace"), b])
			var space = Furnace.instance()
			space.position = b
			add_child(space)
			services.erase("Furnace")
			VertSpotsCopy.erase(b)
			continue
		if services.has("Theatre"):
			shopSpots.append([services_reference.find("Theatre"), b])
			var space = Theatre.instance()
			space.position = b
			add_child(space)
			services.erase("Theatre")
			VertSpotsCopy.erase(b)
			continue
			
	for b in TopSpots:
		if services.has("Mining"):
			shopSpots.append([services_reference.find("Mining"), b])
			var space = Mining.instance()
			space.position = b
			add_child(space)
			TopSpotsCopy.erase(b)
			services.erase("Mining")

			continue
		if services.has("Mechanic"):
			shopSpots.append([services_reference.find("Mechanic"), b])
			var space = Mechanic.instance()
			space.position = b
			add_child(space)
			TopSpotsCopy.erase(b)
			services.erase("Mechanic")

			continue
		if services.has("Data"):
			shopSpots.append([services_reference.find("Data"), b])
			var space = Data.instance()
			space.position = b
			add_child(space)
			TopSpotsCopy.erase(b)
			services.erase("Data")

			continue
		if services.has("Shipping"):
			shopSpots.append([services_reference.find("Shipping"), b])
			var space = Shipping.instance()
			space.position = b
			add_child(space)
			TopSpotsCopy.erase(b)
			services.erase("Shipping")

			continue
		if services.has("Shipyard"):
			shopSpots.append([services_reference.find("Shipyard"), b])
			var space = Shipyard.instance()
			space.position = b
			add_child(space)
			TopSpotsCopy.erase(b)
			services.erase("Shipyard")

			continue
		if services.has("Police"):
			shopSpots.append([services_reference.find("Police"), b])
			var space = Police.instance()
			space.position = b
			add_child(space)
			TopSpotsCopy.erase(b)
			services.erase("Police")
			continue
	if VertSpotsCopy.size() >= 2:
		if services.has("Shipyard"):
			shopSpots.append([services_reference.find("Shipyard"), Vector2(343,363)])
			var space = Shipyard.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Shipyard")
			VertSpotsCopy.pop_back()
			VertSpotsCopy.pop_back()
			
		elif services.has("Police"):
			shopSpots.append([services_reference.find("Police"), Vector2(343,363)])
			var space = Police.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Police")
			VertSpotsCopy.pop_back()
			VertSpotsCopy.pop_back()
		
		elif services.has("Hospital"):
			shopSpots.append([services_reference.find("Hospital"), Vector2(343,363)])
			var space = Hospital.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Hospital")
			VertSpotsCopy.pop_back()
			VertSpotsCopy.pop_back()
			
		elif services.has("Data"):
			shopSpots.append([services_reference.find("Data"), Vector2(343,363)])
			var space = Data.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Data")
			VertSpotsCopy.pop_back()
			VertSpotsCopy.pop_back()

			
		elif services.has("Shipping"):
			shopSpots.append([services_reference.find("Shipping"), Vector2(343,363)])
			var space = Shipping.instance()
			space.position = Vector2(343,363)
			add_child(space)
			services.erase("Shipping")
			VertSpotsCopy.pop_back()
			VertSpotsCopy.pop_back()
			
	if VertSpotsCopy.size() > 0:
		for s in VertSpotsCopy:
			var space = Pillar.instance()
			space.position = s
			add_child(space)
	if TopSpotsCopy.size() > 0:
		for s in TopSpotsCopy:
			var space = Empty.instance()
			space.position = s
			add_child(space)



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
	var owners = []
	for r in get_tree().get_nodes_in_group("World")[0].residents:
		var thing = NPCT.instance()
		thing.service_ability = r.service_ability
		if r.business_owner:
			owners.append(thing)
		else:
			thing.position = player.position + Vector2((-randi() % 200) - 800, (-randi() % 500) - 200)
		thing.modulate = getRandomColor()
		thing.details = r

		self.add_child(thing)
		thing.add_to_group("people")
	for s in shopSpots:
		var max_skill = 0
		var best_owner = null
		for r in owners:
			if r.service_ability[s[0]] > max_skill:
				max_skill = r.service_ability[s[0]] 
				best_owner = r
		owners.erase(best_owner)
		if s[1] is Vector2 && best_owner!=null:
			best_owner.position = s[1]
			best_owner.posting = s[1]
			
		
	
	var exit = Exit.instance()
	add_child(exit)
	exit.position = Vector2(1900, 1200)
	exit.connect("leaving_level", self, "reload_level")
	


func reload_level():
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
	interactPanel.visible = true
	if r.avatar:
		interactSprite.frame = r.avatar
	interactLabel.text = "Name: " + String(r.name) + "\n" + "Age: " + String(r.age) + "\n" + "Culture: " + String(r.culture) + "\n" # + String(r.quests[0].locations_visited) + "\n" + String(r.quests[0].reward) + "\n"
	interactLabel.text += "Boredom: " + String(r.boredom) + "\n" + "Happiness: " + String(r.happiness) + "\n" + "Wealth: " + String(r.wealth) + "\n" + "Criminality: " + String(r.criminality) + "\n" + "Owner: " + String(r.business_owner) + "\n" + "Knowledge: \n"
	
	for t in r.skills:
		interactLabel.text += "  " + t + "\n"
		

	pass

