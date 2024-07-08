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
const Bus = preload('res://Scenes/NPCShips/Bus.tscn')
const Tractor = preload('res://Scenes/NPCShips/Tractor.tscn')

const FacsimaWarParty = preload('res://Scenes/Groups/FacsimaWarParty.tscn')
const CivilianWarParty = preload('res://Scenes/Groups/CivilianWarParty.tscn')
const AstraeWarParty = preload('res://Scenes/Groups/AstraeWarParty.tscn')
const LucianWarParty = preload('res://Scenes/Groups/LucianWarParty.tscn')

#const Planet = preload('res://Scenes/Props/Planet.tscn')
#const Planet2 = preload('res://Scenes/Props/Planet2.tscn')
const Planet3 = preload('res://Scenes/Props/Planet3.tscn')
#const Planet4 = preload('res://Scenes/Props/Planet4.tscn')
#const Planet5 = preload('res://Scenes/Props/Planet5.tscn')
#const Planet6 = preload('res://Scenes/Props/Planet6.tscn')
#const Planet7 = preload('res://Scenes/Props/Planet7.tscn')
#const Planet8 = preload('res://Scenes/Props/Planet8.tscn')
const Planet32 = preload('res://Scenes/Props/Planet32.tscn')
const Planet33 = preload('res://Scenes/Props/Planet33.tscn')
const Planet34 = preload('res://Scenes/Props/Planet34.tscn')
const Planet35 = preload('res://Scenes/Props/Planet35.tscn')
const Planet36 = preload('res://Scenes/Props/Planet36.tscn')

const Farm = preload('res://Scenes/Props/Farm.tscn')
const PirateBay = preload('res://Scenes/Props/PirateBay.tscn')

const Asteroid1 = preload('res://Scenes/Props/Asteroid1.tscn')
const Asteroid2 = preload('res://Scenes/Props/Asteroid2.tscn')
const Asteroid3 = preload('res://Scenes/Props/Asteroid3.tscn')
const Asteroid4 = preload('res://Scenes/Props/Asteroid4.tscn')

var t = Timer.new()

var lastpos;
var checked = []

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

var test = [Vector2(100,100),Vector2(200,200),Vector2(300,300),Vector2(100,200),Vector2(100,300)]

func TSPNearestNeighbor(nodes):
	var soln = []
#	soln.append(nodes[0])
	var matrix = [];
	var matrix_width = nodes.size()
	for i in matrix_width:
		matrix.append([])
		for j in nodes:
			if nodes[i].distance_to(j) == 0:
				matrix[i].append(99999999999)
			else:
				matrix[i].append(nodes[i].distance_to(j))
	var temp = 0
	var pre_temp = 0


	for n in matrix_width:
		pre_temp = temp
#		print(matrix[temp].min())
#		print(temp)
		temp = matrix[temp].find(matrix[temp].min())
		matrix[pre_temp][temp] = 99999999999
		matrix[temp][pre_temp] = 99999999999
		soln.append(nodes[temp])
		for i in matrix_width:
			matrix[i][temp] = 99999999999

#	for n in matrix_width:
#		print(matrix[n])

#	for i in (soln.size() - 4):
#		if((i+2)<soln.size()):
#			var a = soln[i]
#			var b = soln[i+1]
#			var c = soln[i+2]
#
#			if a == c:
#				soln.remove(i)
#				print("removeddupe")
	return soln
	
func array_unique(array: Array) -> Array:
	var unique: Array = []

	for item in array:
		if not unique.has(item):
			unique.append(item)

	return unique

func _ready():
	TSPNearestNeighbor(test)
	add_child(t)
	t.one_shot = true
	t.start(2)
	
	var queue = []
	var points = []
	var cities = []
	var finished_planets = []
	var bus_queue = []
	for p in get_tree().get_nodes_in_group("mapPlanets"):
		points.append((p.position - Vector2(800, 500))*1000)
		cities.append((p.position - Vector2(800, 500))*1000)
		
	
	
	lastpos = Player.position
	
	self.add_to_group("World")
	for g in get_tree().get_nodes_in_group("Galaxy"):
		nodes = g.nodes
		bus_queue = g.queue
	
	var rng = RandomNumberGenerator.new()
	for n in nodes:
#		print(n.name)
#		print(n.pos.x, " ", n.pos.y)

		rng.randomize()
		var planet = planet_choices[rng.randi_range(0,5)].instance()
		
		var broadside = Broadside.instance()
		
		rng.randomize()

		broadside.position = ((n.pos - Vector2(800, 500)) *1000) + Vector2(3000,0)
		broadside.origin = ((n.pos - Vector2(800, 500)) *1000)
		broadside.z_index = 1
		broadside.places = nodes
		broadside.health = 15
		broadside.MAX = 500
		broadside.add_to_group("NPCs")

		var shuttle = Shuttle.instance()
		
		rng.randomize()

		shuttle.position = ((n.pos - Vector2(800, 500)) *1000) + Vector2(-3000,0)
		shuttle.origin = ((n.pos - Vector2(800, 500)) *1000)
		shuttle.z_index = 1
		shuttle.places = nodes
		shuttle.health = 10
		shuttle.MAX = 1500
		shuttle.add_to_group("NPCs")

		shuttle.pre_target = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		
		add_child(shuttle)

		
		var pos = n.pos - Vector2(800, 500)
		
		var l = Label.new()
		l.text = n.name
		
		planet.position = pos *1000
		planet.node = n
		planet.rotation_degrees = (randi() % 4) * 90
		planet.z_index = 0
		l.set_position(planet.position)
		l.rect_scale = Vector2(5,5)
		
		
		var temp = rng.randi_range(100, 150) * coeff
		planet.scale = Vector2(temp,temp)

#		self.add_child(planet)
		finished_planets.append(planet)
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
					broadside.pre_target = (i.pos - Vector2(800, 500))*1000
					self.add_child(broadside)
			else:
				broadside.queue_free()
			if (planet.position.distance_to(((i.pos - Vector2(800, 500)) * 1000)) < 50000):
				var line = Line2D.new()
			

				line.add_point(pos *1000)
			
				line.add_point(((i.pos - Vector2(800, 500)) * 1000))
				var lineColor = Color(i.color)
				lineColor.a = .05
				line.default_color = lineColor
				line.z_index = 0

				if planet.position.distance_to(((i.pos - Vector2(800, 500)) * 1000)) != 0:
					line.width = 10000000 / planet.position.distance_to(((i.pos - Vector2(800, 500)) * 1000))
				line.z_index = -1
				line.add_to_group("NavLines")
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
				line.add_to_group("NavLines")
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
	for i in 10:
		var drone = LancerDrone.instance()
		rng = RandomNumberGenerator.new()
		rng.randomize()

		drone.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		drone.z_index = 0
		drone.attacker = true
		self.add_child(drone)
		drone.add_to_group("drones")
		drone.add_to_group("NPCs")
		
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
#	for i in 15:
#		var drone = PirateRammer.instance()
#		var rng = RandomNumberGenerator.new()
#		rng.randomize()
#
#		drone.position = Vector2(rng.randi_range(sep*10,-sep*10), rng.randi_range(sep*10,-sep*10))
#		drone.z_index = 0
#		self.add_child(drone)
#		drone.add_to_group("drones")
#
#
	for i in 50:
		var asteroid = Asteroid2.instance()

		rng.randomize()

		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		asteroid.z_index = 0
		var temp = rng.randi_range(35, 50)  * 20

		asteroid.rotate(rng.randi_range(0, 360))
		self.add_child(asteroid)
		asteroid.add_to_group("asteroids")
	for i in 50:
		var asteroid = Asteroid3.instance()

		rng.randomize()

		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		asteroid.z_index = 0
		var temp = rng.randi_range(35, 50) 

		asteroid.rotate(rng.randi_range(0, 360))
		self.add_child(asteroid)
		asteroid.add_to_group("asteroids")
	for i in 50:
		var asteroid = Asteroid4.instance()

		rng.randomize()

		asteroid.position = Vector2(rng.randi_range(sep,-sep), rng.randi_range(sep,-sep))
		asteroid.z_index = 0
		var temp = rng.randi_range(35, 50) 

		asteroid.rotate(rng.randi_range(0, 360))
		self.add_child(asteroid)
		asteroid.add_to_group("asteroids")
	for i in 200:
		var farm = Farm.instance()

		rng.randomize()

		farm.position = Vector2(rng.randi_range(sep*7,-sep*7), rng.randi_range(sep*7,-sep*7))
		farm.z_index = 0

		
		var too_close = false
		
		for n in nodes:
			var pos = n.pos - Vector2(800, 500)
			pos = pos * 1000
			
			if farm.position.distance_to(pos) < 4000:
				too_close = true

		
		if too_close:
			farm.queue_free()
		else:
			var farmer = null
			var family_members = []
			var lovers = []
			var family = []
			for n in nodes:
				if farmer == null:
					
					for r in n.residents:
						if r.homestead_candidate && farmer == null:
							family_members = r.family
							lovers = r.lovers
							farmer = r
							family.append(farmer)
							n.residents.erase(r)
						for m in family_members:
							if r.name == m:
								family.append(r)
							
						for l in lovers:
							if r.name == l:
								family.append(r)
				else:
					break
					
			if family.size() > 0:
				farm.residents = family
				farm.add_to_group("planets")
				points.append(farm.position + Vector2(200,200))
				self.add_child(farm)
			else:
				farm.queue_free()
	for i in 20:
		var pirateBay = PirateBay.instance()

		rng.randomize()

		pirateBay.position = Vector2(rng.randi_range(sep*8,-sep*8), rng.randi_range(sep*8,-sep*8))
		pirateBay.z_index = 0

		
		
		var too_close = false
		
		for n in nodes:
			var pos = n.pos - Vector2(800, 500)
			pos = pos * 1000
			
			if pirateBay.position.distance_to(pos) < 4000:
				too_close = true

		
		if too_close:
			pirateBay.queue_free()
		else:
			var closest = null
			var second_closest = null
			var third_closest = null
			for n in nodes:
				var pos = n.pos - Vector2(800, 500)
				pos = pos * 1000
				if closest == null:
					closest = n
					second_closest = n
					third_closest = n
				elif pirateBay.position.distance_to(pos) < pirateBay.position.distance_to((closest.pos - Vector2(800, 500)) * 1000):
					third_closest = second_closest
					second_closest = closest
					closest = n
			closest.piracy_score = closest.piracy_score + 10
			second_closest.piracy_score = second_closest.piracy_score + 6
			third_closest.piracy_score = third_closest.piracy_score + 3
			pirateBay.add_to_group("pirates")
			var raidingline = Line2D.new()
			
			var sides = PoolColorArray()
			var colour = PoolColorArray()
			
			var raiding_queue = [pirateBay.position,((closest.pos - Vector2(800, 500)) * 1000),((second_closest.pos - Vector2(800, 500)) * 1000),((third_closest.pos - Vector2(800, 500)) * 1000), pirateBay.position]
			var drone = PirateRammer.instance()
			
			sides = raiding_queue
			colour = [Color.aliceblue]
			
			var poly = Polygon2D.new()
			poly.z_index = 0
			poly.polygon = sides
			poly.color = Color(.95, .94, .2, .1)
			
			self.add_child(poly)
			
			draw_polygon(sides,colour)

			drone.position = pirateBay.position
			drone.pre_target = raiding_queue[1]
			drone.origin = pirateBay.position
			drone.z_index = 2
			drone.queue = raiding_queue
			drone.health = 10
			drone.MAX = 2500
			drone.add_to_group("NPCs")
			
			self.add_child(drone)

			
			for r in raiding_queue:
				raidingline.add_point(r)
			raidingline.width = 15
			raidingline.default_color = Color.gold
			self.add_child(raidingline)
			raidingline.add_to_group("NavLines")
			self.add_child(pirateBay)
		
	points.shuffle()
	cities.shuffle()
	var dupe_queue = TSPNearestNeighbor(points)
	
	queue = array_unique(dupe_queue)
	

	var tractorline = Line2D.new()
	
	for l in queue:
		tractorline.add_point(l)
	tractorline.width = 10
	tractorline.default_color = Color.crimson
	tractorline.add_to_group("NavLines")
	self.add_child(tractorline)
	
	for i in int(queue.size() / 5):
		var tractor = Tractor.instance()

		rng.randomize()
		tractor.position = (queue[i*4])
		tractor.pre_target = queue[(i*4) + 1]
		tractor.origin = (queue[i*4])
		tractor.z_index = 1
		tractor.queue = queue
		tractor.health = 25
		tractor.MAX = 2500
		tractor.add_to_group("NPCs")
		if(i == queue.size()):
			tractor.dest_index = 0
		else:
			tractor.dest_index = (i*4)+1

		self.add_child(tractor)
		
	
	for i in int(bus_queue.size()/2):
		var bus = Bus.instance()

		rng.randomize()
		bus.position = (bus_queue[i*2])
		bus.pre_target = bus_queue[(i*2) + 1]
		bus.origin = (bus_queue[i*2])
		bus.z_index = 1
		bus.places = nodes
		bus.queue = bus_queue
		bus.health = 20
		bus.MAX = 2000
		bus.add_to_group("NPCs")
		if(i == int(bus_queue.size()/2)):
			bus.dest_index = 0
		else:
			bus.dest_index = i*2+1

		self.add_child(bus)
		
	var line = Line2D.new()
	
	for l in bus_queue:
		line.add_point(l)
	line.width = 5
	line.add_to_group("NavLines")
	self.add_child(line)
	
	for f in finished_planets:
		self.add_child(f)
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
			add_child(asteroid)
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
	for d in get_tree().get_nodes_in_group("NPCs"):
		d.paused = true
	Player.crash()
	paused = true

func unpause():
	paused = false
	addAsteroids()
	for d in get_tree().get_nodes_in_group("NPCs"):
		d.paused = false


var index = 0
var placeName
var message = ""
var residents = []
var services = []
var culture = "";
var runs = 0

func _physics_process(delta):
	runs = runs + 1
	var i = -1
	
	if runs % 300 == 0:
		
		for g in get_tree().get_nodes_in_group("Galaxy"):
			print("genstep( ", (runs/100) % g.nodes.size())
			g.currentplace = (runs/100) % g.nodes.size()
			g.genStep(true)
	
	if !paused:
			
		for a in get_tree().get_nodes_in_group("lines"):
			if checked.size() < get_tree().get_nodes_in_group("lines").size():
				checked.append(false)
			else:
				i = i + 1
			if(Geometry.segment_intersects_segment_2d(((a.points[0] - Vector2(800, 500))*1000), ((a.points[1] - Vector2(800, 500))*1000), lastpos, Player.position) != null) && !checked[i] && ((a.points[0] - Vector2(800, 500))*1000).distance_to(Player.position) > 10000 && ((a.points[1] - Vector2(800, 500))*1000).distance_to(Player.position) > 10000:
				if t.is_stopped():
					t.start(20)
					for n in nodes:
						var pos = n.pos - Vector2(800, 500)
						pos = pos * 1000
						if ((a.points[0] - Vector2(800, 500))*1000).distance_to(pos) < 1000:
							print("spawing " , n.culture)
							var Party = CivilianWarParty.instance()
							if n.culture == "F":
								Party = FacsimaWarParty.instance()
							elif n.culture == "A":
								Party = AstraeWarParty.instance()
							elif n.culture == "E":
								Party = LucianWarParty.instance()
							
							checked[i] = true
							print(Player.position)
							var intersect = Geometry.segment_intersects_segment_2d(((a.points[0] - Vector2(800, 500))*1000), ((a.points[1] - Vector2(800, 500))*1000), lastpos, Player.position)
							print(intersect)

							Party.position = ((a.points[0] - Vector2(800, 500))*1000)
							Party.origin = ((a.points[0] - Vector2(800, 500))*1000)
							Party.destination = ((a.points[1] - Vector2(800, 500))*1000)
							Party.z_index = 1
			

							self.add_child(Party)
						if ((a.points[1] - Vector2(800, 500))*1000).distance_to(pos) < 1000:
							print("spawing " , n.culture)
							var Party = CivilianWarParty.instance()
							if n.culture == "F":
								Party = FacsimaWarParty.instance()
							elif n.culture == "A":
								Party = AstraeWarParty.instance()
							elif n.culture == "E":
								Party = LucianWarParty.instance()
							
							checked[i] = true
							print(Player.position)
							var intersect = Geometry.segment_intersects_segment_2d(((a.points[0] - Vector2(800, 500))*1000), ((a.points[1] - Vector2(800, 500))*1000), lastpos, Player.position)
							print(intersect)

							Party.position = ((a.points[1] - Vector2(800, 500))*1000)
							Party.destination = ((a.points[0] - Vector2(800, 500))*1000)
							Party.origin = ((a.points[1] - Vector2(800, 500))*1000)
							Party.z_index = 1
	

							self.add_child(Party)

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
	if runs % 20 == 0:
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
			
			if Player.position.distance_to(pos) < 4000:
				residents = n.residents
				place = n.name
				placeName = n.name
				culture = n.culture
				welcome.text = "Welcome to " +n.name
				welcome.visible = true
				n.check_Services()
				services = n.services
	#			print(n.services)

			else:
				pass
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
	lastpos = Player.position

