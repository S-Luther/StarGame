extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
#onready var LeftB = $LeftBounds
#onready var RightB = $RightBounds
#onready var TopB = $TopBounds
#onready var BottomB = $BottomBounds
onready var timer = $Timer
onready var welcome = $Player/Engine/NavTerminal/UI/Welcome
onready var Player = $Player

const LancerDrone = preload('res://Scenes/NPCShips/LancerDrone.tscn')
const FacsSapling = preload('res://Scenes/NPCShips/FacsSaplingNPC.tscn')
const ShieldMaiden = preload('res://Scenes/NPCShips/ShieldMaidenNPC.tscn')
const FacsLeaflet = preload('res://Scenes/NPCShips/FacsLeaflet.tscn')
const Expeditionary = preload('res://Scenes/NPCShips/Expeditionary.tscn')
const Broadside = preload('res://Scenes/NPCShips/Broadside.tscn')
const Orb = preload('res://Scenes/NPCShips/Orb.tscn')
const Platform = preload('res://Scenes/NPCShips/Platform.tscn')
const FighterPlatform = preload('res://Scenes/NPCShips/FighterPlatform.tscn')
const PirateRammer = preload('res://Scenes/NPCShips/PirateRammer.tscn')
const Shuttle = preload('res://Scenes/NPCShips/Shuttle.tscn')

const Planet = preload('res://Scenes/Props/Planet.tscn')
const Planet2 = preload('res://Scenes/Props/Planet2.tscn')
const Planet3 = preload('res://Scenes/Props/Planet3.tscn')
const Planet4 = preload('res://Scenes/Props/Planet4.tscn')
const Planet5 = preload('res://Scenes/Props/Planet5.tscn')
const Planet6 = preload('res://Scenes/Props/Planet6.tscn')
const Planet7 = preload('res://Scenes/Props/Planet7.tscn')
const Planet8 = preload('res://Scenes/Props/Planet8.tscn')
const Planet32 = preload('res://Scenes/Props/Planet32.tscn')
const Planet33 = preload('res://Scenes/Props/Planet33.tscn')
const Planet34 = preload('res://Scenes/Props/Planet34.tscn')
const Planet35 = preload('res://Scenes/Props/Planet35.tscn')
const Planet36 = preload('res://Scenes/Props/Planet36.tscn')

const Asteroid1 = preload('res://Scenes/Props/Asteroid1.tscn')
const Asteroid2 = preload('res://Scenes/Props/Asteroid2.tscn')
const Asteroid3 = preload('res://Scenes/Props/Asteroid3.tscn')
const Asteroid4 = preload('res://Scenes/Props/Asteroid4.tscn')

var t = Timer.new()

#const Asteroid5 = preload('res://Scenes/Props/Asteroid5.tscn')
#const Asteroid6 = preload('res://Scenes/Props/Asteroid6.tscn')
#const Asteroid7 = preload('res://Scenes/Props/Asteroid7.tscn')
var coeff = .25
var sep = 40000
var nodes = []
var planet_choices = [Planet3, Planet32, Planet33, Planet34, Planet35, Planet36]

var minerals = 0;
var liquids = 0;
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(t)
	t.one_shot = true
	t.start(2)
	
	self.add_to_group("World")
	for g in get_tree().get_nodes_in_group("Galaxy"):
		nodes = g.nodes
	
	for n in nodes:
#		print(n.name)
#		print(n.pos.x, " ", n.pos.y)
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var planet = planet_choices[rng.randi_range(0,5)].instance()
		
		var drone = Broadside.instance()
		
		rng.randomize()

		drone.position = ((n.pos - Vector2(800, 500)) *1000)
		drone.origin = ((n.pos - Vector2(800, 500)) *1000)
		drone.z_index = 1

		var shuttle = Shuttle.instance()
		
		rng.randomize()

		shuttle.position = ((n.pos - Vector2(800, 500)) *1000)
		shuttle.origin = ((n.pos - Vector2(800, 500)) *1000)
		shuttle.z_index = 1
		shuttle.pre_target = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		
		self.add_child(shuttle)

		
		var pos = n.pos - Vector2(800, 500)
		
		var l = Label.new()
		l.text = n.name
		
		planet.position = pos *1000
		planet.rotation_degrees = (randi() % 4) * 90
		planet.z_index = 0
		l.set_position(planet.position)
		l.rect_scale = Vector2(5,5)
		
		
		var temp = rng.randi_range(100, 150) * coeff
		planet.scale = Vector2(temp,temp)

		self.add_child(planet)
		planet.add_to_group("planets")
		
		if Player.position.distance_to(pos) < 2000:
			welcome.text = "Welcome to " +n.name
			welcome.visible = true
#			get_tree().get_nodes_in_group("Galaxy")[0].Place.add_to_group("current_location")
	
		var neighb = 0
		if(n.neighbors.size() > 0):
			neighb = rng.randi() % n.neighbors.size()
		for i in nodes:
			if(n.neighbors.size() > 0):
				if(i.name == n.neighbors[neighb]):
					drone.pre_target = (i.pos - Vector2(800, 500))*1000
					self.add_child(drone)
			else:
				drone.queue_free()
			if (planet.position.distance_to(((i.pos - Vector2(800, 500)) * 1000)) < 50000):
				var line = Line2D.new()
				line.add_point(pos *1000)
				line.add_point(((i.pos - Vector2(800, 500)) * 1000))
				var lineColor = Color(i.color)
				lineColor.a = .05
				line.default_color = lineColor

				if planet.position.distance_to(((i.pos - Vector2(800, 500)) * 1000)) != 0:
					line.width = 10000000 / planet.position.distance_to(((i.pos - Vector2(800, 500)) * 1000))
				line.z_index = -1
				self.add_child(line)
			elif (n.neighbors.has(i.name)):
				var line = Line2D.new()
				line.add_point(pos *1000)
				line.add_point(((i.pos - Vector2(800, 500)) * 1000))
				var lineColor = Color(i.color)
				lineColor.a = .1
				line.default_color = lineColor
				if planet.position.distance_to(((i.pos - Vector2(800, 500)) * 1000)) != 0:
					line.width = 10000000 / planet.position.distance_to(((i.pos - Vector2(800, 500)) * 1000))
				
				line.z_index = -1
				self.add_child(line)

		

#	RightB.position.x = RightB.position.x - .5
#	RightB.add_to_group("RightB")
#	LeftB.position.x = LeftB.position.x + .5
#	LeftB.add_to_group("LeftB")
#	TopB.position.y = TopB.position.y + .5
#	TopB.add_to_group("TopB")
#	BottomB.position.y = BottomB.position.y - .5
#	BottomB.add_to_group("BottomB")


#	for i in 20:
#		var planet = Planet.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		planet.position = Vector2(rng.randi_range(LeftB.get_position().x + 3000, RightB.get_position().x - 3000), rng.randi_range(TopB.get_position().y + 3000, BottomB.get_position().y - 3000))
#		planet.z_index = 0
#		var temp = rng.randi_range(50, 100) * coeff
#		planet.scale = Vector2(temp,temp)
#
#		self.add_child(planet)
#		planet.add_to_group("planets")
#	for i in 20:
#		var planet = Planet2.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		planet.position = Vector2(rng.randi_range(LeftB.get_position().x + 3000, RightB.get_position().x - 3000), rng.randi_range(TopB.get_position().y + 3000, BottomB.get_position().y - 3000))
#		planet.z_index = 0
#		var temp = rng.randi_range(50, 100) * coeff
#		planet.scale = Vector2(temp,temp)
#
#		self.add_child(planet)
#		planet.add_to_group("planets")
#	for i in 50:
#		var planet = Planet3.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		planet.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		planet.z_index = 0
#		var temp = rng.randi_range(100, 150) * coeff
#		planet.scale = Vector2(temp,temp)
#
#		self.add_child(planet)
#		planet.add_to_group("planets")
#	for i in 20:
#		var planet = Planet6.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		planet.position = Vector2(rng.randi_range(LeftB.get_position().x + 3000, RightB.get_position().x - 3000), rng.randi_range(TopB.get_position().y + 3000, BottomB.get_position().y - 3000))
#		planet.z_index = 0
#		var temp = rng.randi_range(50, 100) * coeff
#		planet.scale = Vector2(temp,temp)
#
#		self.add_child(planet)
#		planet.add_to_group("planets")
#	for i in 20:
#		var planet = Planet7.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		planet.position = Vector2(rng.randi_range(LeftB.get_position().x + 3000, RightB.get_position().x - 3000), rng.randi_range(TopB.get_position().y + 3000, BottomB.get_position().y - 3000))
#		planet.z_index = 0
#		var temp = rng.randi_range(50, 100) * coeff
#		planet.scale = Vector2(temp,temp)
#
#		self.add_child(planet)
#		planet.add_to_group("planets")
#	for i in 20:
#		var planet = Planet8.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		planet.position = Vector2(rng.randi_range(LeftB.get_position().x + 3000, RightB.get_position().x - 3000), rng.randi_range(TopB.get_position().y + 3000, BottomB.get_position().y - 3000))
#		planet.z_index = 0
#		var temp = rng.randi_range(50, 100) * coeff
#		planet.scale = Vector2(temp,temp)
#
#		self.add_child(planet)
#		planet.add_to_group("planets")
	for i in 50:
		var asteroid = Asteroid1.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		asteroid.z_index = 0
		var temp = rng.randi_range(35, 50) * 2
#		asteroid.tran.scale = Vector2(temp,temp)
		asteroid.rotate(rng.randi_range(0, 360))
		self.add_child(asteroid)
		asteroid.add_to_group("asteroids")
#		asteroid.velocity = Vector2(rng.randi_range(10,-10), rng.randi_range(10,-10))
##
#	for i in 50:
#		var drone = LancerDrone.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
		
#	for i in 5:
#		var drone = ShieldMaiden.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
#	for i in 5:
#		var drone = FacsLeaflet.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
#	for i in 5:
#		var drone = Expeditionary.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
#	for i in 5:
#		var drone = FacsSapling.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
#	for i in 5:
#		var drone = ShieldMaiden.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
###
#	for i in 5:
#		var drone = Broadside.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
#	for i in 5:
#		var drone = Platform.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
#	for i in 5:
#		var drone = FighterPlatform.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
#	for i in 5:
#		var drone = Orb.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
#	for i in 5:
#		var drone = Shuttle.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
	for i in 15:
		var drone = PirateRammer.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		drone.position = Vector2(rng.randi_range(sep*10,-sep*10), rng.randi_range(sep*10,-sep*10))
		drone.z_index = 0
		self.add_child(drone)
		drone.add_to_group("drones")
#
#
	for i in 50:
		var asteroid = Asteroid2.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		asteroid.z_index = 0
		var temp = rng.randi_range(35, 50)  * 20

		asteroid.rotate(rng.randi_range(0, 360))
		self.add_child(asteroid)
		asteroid.add_to_group("asteroids")
	for i in 50:
		var asteroid = Asteroid3.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		asteroid.z_index = 0
		var temp = rng.randi_range(35, 50) 

		asteroid.rotate(rng.randi_range(0, 360))
		self.add_child(asteroid)
		asteroid.add_to_group("asteroids")
	for i in 50:
		var asteroid = Asteroid4.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		asteroid.z_index = 0
		var temp = rng.randi_range(35, 50) 

		asteroid.rotate(rng.randi_range(0, 360))
		self.add_child(asteroid)
		asteroid.add_to_group("asteroids")
#	for i in 20:
#		var asteroid = Asteroid5.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		asteroid.z_index = 0
#		var temp = rng.randi_range(25, 50) * .8
#		asteroid.scale = Vector2(temp,temp)
#		asteroid.rotate(rng.randi_range(0, 360))
#		self.add_child(asteroid)
#		asteroid.add_to_group("asteroids")
#	for i in 20:
#		var asteroid = Asteroid6.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		asteroid.z_index = 0
#		var temp = rng.randi_range(25, 50) * .8
#		asteroid.scale = Vector2(temp,temp)
#		asteroid.rotate(rng.randi_range(0, 360))
#		self.add_child(asteroid)
#		asteroid.add_to_group("asteroids")
#	for i in 20:
#		var asteroid = Asteroid7.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		asteroid.z_index = 0
#		var temp = rng.randi_range(25, 50) * .8
#		asteroid.scale = Vector2(temp,temp)
#		asteroid.rotate(rng.randi_range(0, 360))
#		self.add_child(asteroid)
#		asteroid.add_to_group("asteroids")	
func addAsteroids():
	for i in 50:
		var asteroid = Asteroid2.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		
		var x = rng.randi_range(sep,-sep)
		var y = rng.randi_range(sep,-sep)
		
		if x > 4000 || x < -4000 || y > 4000 || y < -4000:
			asteroid.position = Vector2(x,y) + Player.position
			asteroid.z_index = 0
			var temp = rng.randi_range(35, 50)  * 20

			asteroid.rotate(rng.randi_range(0, 360))
			self.add_child(asteroid)
			asteroid.add_to_group("asteroids")
	for i in 50:
		var asteroid = Asteroid3.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		var x = rng.randi_range(sep,-sep)
		var y = rng.randi_range(sep,-sep)
		
		if x > 4000 || x < -4000 || y > 4000 || y < -4000:
			asteroid.position = Vector2(x,y) + Player.position
			asteroid.z_index = 0
			var temp = rng.randi_range(35, 50) 

			asteroid.rotate(rng.randi_range(0, 360))
			self.add_child(asteroid)
			asteroid.add_to_group("asteroids")
	for i in 50:
		var asteroid = Asteroid4.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		var x = rng.randi_range(sep,-sep)
		var y = rng.randi_range(sep,-sep)
		
		if x > 4000 || x < -4000 || y > 4000 || y < -4000:
			asteroid.position = Vector2(x,y) + Player.position
			asteroid.z_index = 0
			var temp = rng.randi_range(35, 50) 

			asteroid.rotate(rng.randi_range(0, 360))
			self.add_child(asteroid)
			asteroid.add_to_group("asteroids")
	for i in 50:
		var asteroid = Asteroid1.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var x = rng.randi_range(sep,-sep)
		var y = rng.randi_range(sep,-sep)
		if x > 4000 || x < -4000 || y > 4000 || y < -4000:
			asteroid.position = Vector2(x,y) + Player.position
			asteroid.z_index = 0
			var temp = rng.randi_range(35, 50) 

			asteroid.rotate(rng.randi_range(0, 360))
			self.add_child(asteroid)
			asteroid.add_to_group("asteroids")

var paused = false

func pause():
	for a in get_tree().get_nodes_in_group("asteroids"):
		a.queue_free()
	for d in get_tree().get_nodes_in_group("drones"):
		d.queue_free()
	Player.crash()
	paused = true

func unpause():
	paused = false
	addAsteroids()


var index = 0
var placeName
var message = ""
var residents = []
var culture = "";

func _process(delta):
	
	var place = ""
	
#	if t.is_stopped():
#		t.start(.2)
#		var string = "Welcome to " + placeName
#		message = ""
#
#
#		if index < string.length():
#			for i in range(index):
#				message = message + string[i]
#			index = index + 1
#addAsteroids()
	var count = 0;
	for a in get_tree().get_nodes_in_group("asteroids"):
		count = count + 1
		if a.position.distance_to(Player.position) > 50000:
			a.queue_free()
			
	if count < 100 && !paused:
		addAsteroids()
	for n in nodes:
		var pos = n.pos - Vector2(800, 500)
		pos = pos * 1000
		if Player.position.distance_to(pos) < 3000:
			residents = n.residents
			place = n.name
			placeName = n.name
			culture = n.culture
			welcome.text = "Welcome to " +n.name
			welcome.visible = true

#		else:
#			print("none")
	
	if place == "":
		message = ""
		placeName = ""
		index = 0
		welcome.visible = false

		#player.radar(player.get_position(),asteroids,planets,abs(LeftBD),abs(RightBD),abs(TopBD),abs(BottomBD))
		#	RightB.position.x = RightB.position.x - .55
		#	LeftB.position.x = LeftB.position.x + .55
		#	TopB.position.y = TopB.position.y + .55
		#	BottomB.position.y = BottomB.position.y - .55

