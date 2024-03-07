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

const Planet = preload('res://Scenes/Props/Planet.tscn')
const Planet2 = preload('res://Scenes/Props/Planet2.tscn')
const Planet3 = preload('res://Scenes/Props/Planet3.tscn')
const Planet4 = preload('res://Scenes/Props/Planet4.tscn')
const Planet5 = preload('res://Scenes/Props/Planet5.tscn')
const Planet6 = preload('res://Scenes/Props/Planet6.tscn')
const Planet7 = preload('res://Scenes/Props/Planet7.tscn')
const Planet8 = preload('res://Scenes/Props/Planet8.tscn')

const Asteroid1 = preload('res://Scenes/Props/Asteroid1.tscn')
const Asteroid2 = preload('res://Scenes/Props/Asteroid2.tscn')
const Asteroid3 = preload('res://Scenes/Props/Asteroid3.tscn')
const Asteroid4 = preload('res://Scenes/Props/Asteroid4.tscn')

var t = Timer.new()

#const Asteroid5 = preload('res://Scenes/Props/Asteroid5.tscn')
#const Asteroid6 = preload('res://Scenes/Props/Asteroid6.tscn')
#const Asteroid7 = preload('res://Scenes/Props/Asteroid7.tscn')
var coeff = .25
var sep = 100000
var nodes = []
# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(t)
	t.one_shot = true
	t.start(2)
	
	self.add_to_group("Player")
	for g in get_tree().get_nodes_in_group("Galaxy"):
		nodes = g.nodes
	
	for n in nodes:
		print(n.name)
		print(n.pos.x, " ", n.pos.y)
		var planet = Planet3.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()
		var pos = n.pos - Vector2(800, 500)
		
		var l = Label.new()
		l.text = n.name
		
		planet.position = pos *500
		planet.z_index = 0
		l.set_position(planet.position)
		l.rect_scale = Vector2(5,5)
		
		
		var temp = rng.randi_range(100, 150) * coeff
		planet.scale = Vector2(temp,temp)

		self.add_child(planet)
		planet.add_to_group("planets")
		

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
#	for i in 500:
#		var asteroid = Asteroid1.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		asteroid.z_index = 0
#		var temp = rng.randi_range(35, 50) * 2
##		asteroid.tran.scale = Vector2(temp,temp)
#		asteroid.rotate(rng.randi_range(0, 360))
#		self.add_child(asteroid)
#		asteroid.add_to_group("asteroids")
##		asteroid.velocity = Vector2(rng.randi_range(10,-10), rng.randi_range(10,-10))
#
	for i in 50:
		var drone = LancerDrone.instance()
		var rng = RandomNumberGenerator.new()
		rng.randomize()

		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		drone.z_index = 0
		self.add_child(drone)
		drone.add_to_group("drones")
#
#
#	for i in 500:
#		var asteroid = Asteroid2.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		asteroid.z_index = 0
#		var temp = rng.randi_range(35, 50)  * 20
#
#		asteroid.rotate(rng.randi_range(0, 360))
#		self.add_child(asteroid)
#		asteroid.add_to_group("asteroids")
#	for i in 500:
#		var asteroid = Asteroid3.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		asteroid.z_index = 0
#		var temp = rng.randi_range(35, 50) 
#
#		asteroid.rotate(rng.randi_range(0, 360))
#		self.add_child(asteroid)
#		asteroid.add_to_group("asteroids")
#	for i in 500:
#		var asteroid = Asteroid4.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
#		asteroid.z_index = 0
#		var temp = rng.randi_range(35, 50) 
#
#		asteroid.rotate(rng.randi_range(0, 360))
#		self.add_child(asteroid)
#		asteroid.add_to_group("asteroids")
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

var index = 0
var placeName
var message = ""
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
#
	for n in nodes:
		var pos = n.pos - Vector2(800, 500)
		pos = pos * 500
		if Player.position.distance_to(pos) < 4000:
			place = n.name
			placeName = n.name
			welcome.text = "Welcome to " +n.name
			welcome.visible = true
#			print(n.name)

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

