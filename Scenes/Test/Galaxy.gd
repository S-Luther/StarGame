extends Node2D

const PlanetMarker = preload('res://Scenes/Props/PlanetMarker.tscn')
const AsteroidMarker = preload('res://Scenes/Props/AsteroidMarker.tscn')
const ShotMarker = preload('res://Scenes/Props/ShotMarker.tscn')


var logs = "";

var names;

var Facs = [1,2,3,15,32,40,47,39,37,35,48]

var Lucian = [6,7,8,9,10,14,21,22,23,24,25,45,46]

var Astrae = [11,12,13,16,17,18,19,30,33,34,36,38]

var Pirates = [26,27,28,29,43,44,4,41,42]

var places = []

var step = 0
var currentplace = -1
var currentStep = 0
var totalPop = 0;
var nomad

var Apop = 0;
var Fpop = 0;
var Epop = 0;

var conflicts = []
var positions = []

static func pickRandom(list):
	return list[randi() % list.size()]

var extensions = [
	"ville",
	"ton",
	"shire",
	"ford",
	"port",
	"peak"
]

var cultures = ["A", "F", "E", "A","A", "F", "E", "A", "C"]

var endings = [
	"Cave",
	"Hideout",
	"Getaway",
	"Gateway",
	"Paradise",
	"Portal",
	"Spot",
	"Bungalow",
	"Last Chance",
	"Big Score",
	"Comet",
	"Favorite",
	"Retreat",
	"Stop",
	"Last Stand",
	"Escape",
	"City",
	"Park",
	"Station",
	"Base",
	"Fort",
	"Outpost",
	"Tower",
	"Castle",
	"Prefect",
	"Vista",
	"Star",
	"Belt",
	"Nebula",
]

var factions = [
	"Republic",
	"Coalition",
	"Band",
	"Empire",
	"Traders Guild",
	"Guild",
	"Union",
	"Nation",
	"States",
	"State",
	"Rebels",
	"Emperium",
	"Federation",
	"Dawn",
	"Freaks"
]

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
	var value = 1
	var neighbors = []
	var popular = []
	var unpopular = []
	var visitors = []
	var faction = ""
	var color = ""
	var culture = ""
	
	var first = false
	
	var pos = Vector2.ZERO
	var force = Vector2.ZERO
	var mass = 0.0
	
	func _init(new_name, new_est, new_faction, new_color, new_culture):
		name = new_name
		est = new_est
		faction = new_faction
		color = new_color
		culture = new_culture
		
	func new_Node(new_pos):
		if !first:
			pos = new_pos
		mass = (2 * PI * residents.size())/1.5
		return self
	func update():
		var vel = force / mass
		pos = pos + vel
		if pos.x > 1600 || pos.x < 0 || pos.y > 1000 || pos.y < 0:
			pos = pos - vel
		else:
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
	var travels = []
	var icon = ""
	var boredom = 50
	var happiness = 50
	var culture = ""
	var avatar = 0
	
	func _init(new_name,new_age,new_place, new_enneagram, new_culture):
		name = new_name
		age = new_age
		home = new_place
		travels.append(new_place)
		knowledge.append("SpacePort " + new_place)
		enneagram = new_enneagram
		culture = new_culture
		

func difference(arr1, arr2):
	var only_in_arr1 = []
	for v in arr1:
		if not (v in arr2):
			only_in_arr1.append(v)
	return only_in_arr1
		
func addRandomCharacter(place, pculture) -> Person:
	totalPop = totalPop + 1
	if pculture == "A":
		Apop = Apop + 1
	elif pculture == "F":
		Fpop = Fpop + 1
	else:
		Epop = Epop + 1
	
	var name = pickRandom(names)
	names.pop_at(names.find(name))
	
	var person = Person.new(name,randi() % 90 + 15,place, pickRandom(enneagramCombos),pculture)
	
	if pculture == "F":
		person.avatar = pickRandom(Facs)
	elif pculture == "A":
		person.avatar = pickRandom(Astrae)
	elif pculture == "E":
		person.avatar = pickRandom(Lucian)
	elif pculture == "P":
		person.avatar = pickRandom(Pirates)
	return person
	
func addRandomPlace():
	var name = ""
	if (randi() % 2 == 0):
		name =pickRandom(names) + "'s " + pickRandom(endings) 
	else:
		name =pickRandom(names)+pickRandom(extensions)
	var faction = ""
	if (randi() % 2 == 0):
		faction = pickRandom(names) + "'s " + pickRandom(factions) 
	else: 
		faction = "The " + pickRandom(factions)+" of "+pickRandom(names)
	places.append(Place.new(name, step, faction, getRandomColor(),pickRandom(cultures)))
	currentplace = currentplace + 1

func newBase(seedCharacter):
	
	
	addRandomPlace()

	if seedCharacter != null :
		seedCharacter.happiness=50;
		seedCharacter.boredom=50;
		seedCharacter.travels.append(places[currentplace].name)
		seedCharacter.knowledge.append("SpacePort " + places[currentplace].name)
#		if randi() % 2 == 0:
		places[currentplace].neighbors.append(places[currentplace-1].name)
		places[currentplace-1].neighbors.append(places[currentplace].name)
		
		var randomPlace = pickRandom(places)
		
		if randi() % 5 == 0:
			places[currentplace].neighbors.append(randomPlace.name)
			randomPlace.neighbors.append(places[currentplace].name)
		
		places[currentplace].residents.append(seedCharacter);
	else:
		places[currentplace].pos = Vector2(800,500)
		places[currentplace].first = true
	var residents = 0
	residents = randi() % 40 + 10
	for i in range(residents):
#		print("hi")
		places[currentplace].residents.append(addRandomCharacter(places[currentplace].name, places[currentplace].culture));
#		print(places[currentplace].residents[places[currentplace].residents.size()-1].name)

var cultModifier = 1

func interact(i,j, c):
	var iType = i.enneagram[randi()%3];
	var jType = j.enneagram[randi()%3];
	
	var firstTime = false;
	
	if i.culture != c:
		i.happiness = i.happiness - cultModifier;
	if j.culture != c:
		j.happiness = j.happiness - cultModifier;
	
	if not(i.knowledge.has(j.name)) and not(j.knowledge.has(i.name)):
		i.knowledge.append(j.name);
		j.knowledge.append(i.name);
		firstTime=true;
		i.boredom = i.boredom - 1;
		j.boredom = j.boredom - 1;
		

	if (enneagramCompat[iType-1].has(jType)):
		if (firstTime):
			i.friends.append(j.name);
			j.friends.append(i.name);
		
#        console.log(i.name + " is getting along with " + j.name)
		i.thoughts.append(i.name+" had a positive experience interacting with "+j.name);
		j.thoughts.append(j.name+" had a positive experience interacting with "+i.name);
		i.happiness = i.happiness + 2;
		j.happiness = j.happiness + 2;

		i.boredom = i.boredom - 2;
		j.boredom = j.boredom - 2;

	elif (enneagramNonCompat[iType-1].has(jType)):
		if(firstTime):
			i.enemies.append(j.name);
			j.enemies.append(i.name);
		
#		console.log(i.name + " is annoyed by " + j.name)
		i.thoughts.append(i.name+" had a negative experience interacting with "+j.name);
		j.thoughts.append(j.name+" had a negative experience interacting with "+i.name);

		i.happiness = i.happiness - 3;
		j.happiness = j.happiness - 5;
		i.boredom = i.boredom - 1;
		j.boredom = j.boredom - 1;

	else:
#        i.memories.append(i.name+" didn't feel anything after interacting with "+j.name);
#        j.memories.append(j.name+" didn't feel anything after interacting with "+i.name);
		i.boredom = i.boredom + 4;
		j.boredom = j.boredom + 3;

	if(i.thoughts.size() > 20):
		if((randi() % 1000)<2):
			i.memories.append(i.thoughts.pop_front());
		else:
			i.thoughts.pop_front()
	
	if(j.thoughts.size() > 20):
		if((randi() % 1000)<2):
			j.memories.append(j.thoughts.pop_front());
		else:
			j.thoughts.pop_front()
	
var stop = false;

func genStep():
	for c in places[currentplace].residents:
#		print(c.name)
		interact(c, pickRandom(places[currentplace].residents), places[currentplace].culture);
		if c.happiness<10:
			stop = true;
			nomad = c;
#			print("here")
		if c.boredom>500:
			stop = true;
			nomad = c;
#		print(c.happiness, " ", c.boredom)
	currentStep = currentStep + 1
	
func genSim(steps):
	if(places.size() < 1):
		newBase(null);
	for j in range(steps):
		if(stop):
			var index = places[currentplace].residents.find(nomad);
			places[currentplace].residents.pop_at(index);
			newBase(nomad);
			stop = false;
		else:
			genStep();

func findPlaceByName(placeName):
	for i in range(places.size()):
		if(places[i].name == placeName):
			return i;
		
func cleanStep(residents, cult):
	for c in residents:
		if(!stop):
			interact(c, pickRandom(residents), cult);
			if(c.happiness<30 or c.boredom>100):
				nomad = c;
				stop = true;
			elif(c.happiness>3000 or c.boredom<-3000):
				nomad = c;
				stop = true;

func cleanSim(steps):
	stop = false;
	for p in places:

		for i in range(steps):
			if(stop):
				var newHome = ""
				if p.neighbors.size() > 0:
					newHome = pickRandom(p.neighbors)
					nomad.travels.append(newHome)
					if not(nomad.knowledge.has(newHome)):
						nomad.knowledge.append("SpacePort " + newHome)
				else:
					newHome = pickRandom(places).name
					nomad.travels.append(newHome)
					if not(nomad.knowledge.has(newHome)):
						nomad.knowledge.append("SpacePort " + newHome)
				nomad.boredom = 50;
				nomad.happiness = 50;
				

				places[findPlaceByName(newHome)].residents.append(nomad);
				var index = p.residents.find(nomad);
				p.residents.pop_at(index);
				stop = false;
			
			cleanStep(p.residents, p.culture)
			
func getRandomColor():
	var letters = '0123456789ABCDEF';
	var color = '#';
	for i in range(6):
		color += letters[randi()%12 + 4];
	return color;


var noNodes = 100;
var noConn = 50;
var gravityConstant = 6.1;
var forceConstant = 30000;
var physics = true;

var nodes = [];
var nodeCon = [];
var clicked = false;
var lerpValue = 0.2;
var startDisMultiplier = 10;
var closeNode;
var closeNodeMag;

class Planet:
	var pos
	var force = Vector2.ZERO
	var mass = 0.0
	var name = ""
	var color = ""

	func _init(new_pos, size, new_name, new_color):
		pos = new_pos
		name = new_name
		mass = (2 * PI * size)/1.5
		color = new_color
		
var final = false


func applyForces(Nodes):

	for node in Nodes:
		var pos = Vector2.ZERO;
		pos = node.pos
		var dir = pos.angle_to_point(Vector2(800,500));
		node.force = Vector2(-gravityConstant*node.mass,0).rotated(dir)


	for i in range(Nodes.size()):
		for j in range(Nodes.size()):
			var dir = Nodes[i].pos.angle_to_point(Vector2(Nodes[j].pos));
			var distance = Nodes[i].pos.distance_to(Vector2(Nodes[j].pos))

			if!(distance == 0):
				Nodes[i].force += Vector2(10000/distance,randi()%2).rotated(dir) 
#
#
#
#
	for con in nodeCon:
		var node1 = con[0]
		var node2 = con[1]
		var maxDis = con[2]
		var dis = node1.pos + (-node2.pos)
		var diff = abs(node1.pos.distance_to(node2.pos) - maxDis) + 1
		if node1.pos.distance_to(node2.pos) < maxDis:
			var dir = node1.pos.angle_to_point(node2.pos);
			node1.force += Vector2(5*diff,0).rotated(dir)
		else:
			var dir = node1.pos.angle_to_point(node2.pos);
			node1.force += Vector2(-5*diff,0).rotated(dir)

var clashCount = 0



func clash():
	clashCount = clashCount + 1
	for a in get_tree().get_nodes_in_group("lines"):
		a.queue_free()
	for e in places:
		var attack
		if e.neighbors.size() > 0:
			attack = pickRandom(e.neighbors);
			if e.pos.distance_to(places[findPlaceByName(attack)].pos) > 400:
				attack = null
		else:
			print("no neighbors")
			attack = null;
		var index = -1
		var found = false
		
		if attack != null:
			for p in places:
				if !found:
					index = index + 1
				if attack == p.name:
					found = true
				
			
			if(!(places[index].faction == e.faction)):
				var attackerMight = e.value * e.residents.size() * randf();
				var defenderMight = places[index].value * places[index].residents.size() * randf()
				var line = Line2D.new()
				line.add_point(places[index].pos,1)
				line.add_point(e.pos,2)
				line.default_color = Color(e.color)
				line.width = 4
				add_child(line)
				line.add_to_group("lines")
				
				
				
				if(attackerMight > defenderMight):
					places[index].faction = e.faction;
					places[index].color = e.color;
					places[index].culture = e.culture;

		   
#var t = Timer.new()

var size = 5000;

var finish = false

var collisions = 0;

func getNodes() -> Array:
	return nodes

var spacing = 100;

func build():
	names = names_backup.duplicate()
	runs = 0
	currentplace = -1
	currentStep = 0
	totalPop = 0
	Apop = 0
	Fpop = 0
	Epop = 0
	cultModifier = 0
	places.clear()
	nodes.clear()
	randomize()
	genSim(size)
	cleanSim(1000)
	logs = "Total Pop: " + String(totalPop)+ " Worlds: " + String(places.size()) + "\n"+ logs
	logs = "A Pop: " + String(Apop) + " F Pop: " + String(Fpop) + " E Pop: " + String(Epop) + "\n"+ logs
	
	print("Total Pop: ", totalPop, " Worlds: ", places.size())
	print("A Pop: ", Apop, " F Pop: ", Fpop, " E Pop: ", Epop)
	cultModifier = 10
#	t.one_shot = true
#	t.start(2)
	


	for p in places:
		var pos = Vector2(randi()%1600, randi()%1000)
		nodes.append(p.new_Node(pos))
		var neighb = p.neighbors
		for l in places:
			if neighb.has(l.name):
				nodeCon.append([l, p, spacing])

				
			
	
	

	
var names_backup

func _ready():
	var NameRes = Names.new()
	names = NameRes.names
	names_backup = names.duplicate()
	self.add_to_group("Galaxy")
	build()


		
	
	
var unique_cultures = [10000,10000,10000];
var unique_factions = []
var fullStop = false

func rebuild():
	collisions = 0
	clashCount = 0
	unique_cultures = [10000,10000,10000];
	unique_factions.clear()
	fullStop = false
	for a in get_tree().get_nodes_in_group("mapPlanets"):
		a.queue_free()
	for a in get_tree().get_nodes_in_group("labels"):
		a.queue_free()
	for a in get_tree().get_nodes_in_group("lines"):
		a.queue_free()
	finish = false
	build()

var runs = 0;

func _process(delta):

	var labels = get_tree().get_nodes_in_group("labels")
	
	runs = runs + 1
	
	if runs < 1000:
		for a in get_tree().get_nodes_in_group("lines"):
			a.queue_free()
				
#		for con in nodeCon:
#			var node1 = con[0]
#			var node2 = con[1]
#
#			var line = Line2D.new()
#			line.add_point(node1.pos,1)
#			line.add_point(node2.pos,2)
#			line.width = 1
#			add_child(line)
#			line.add_to_group("lines")
			
		applyForces(nodes)
		

		for a in get_tree().get_nodes_in_group("mapPlanets"):
			a.queue_free()
		for p in nodes:
			if is_nan(p.pos.x) || p.pos.x > 1600 || p.pos.x < 0 || p.pos.y > 1000 || p.pos.y < 0:
				logs =  "Rejected for out of bounds" + "\n"+ logs
				print("Rejected for out of bounds")
				collisions = 0
				clashCount = 0
				unique_cultures = [10000,10000,10000];
				unique_factions.clear()
				for a in get_tree().get_nodes_in_group("mapPlanets"):
					a.queue_free()
				for a in get_tree().get_nodes_in_group("labels"):
					a.queue_free()
				finish = false
				build()
			p.update()
			var asteroidm = PlanetMarker.instance()
			asteroidm.position = p.pos
			asteroidm.scale = Vector2(4,4)
			asteroidm.modulate = p.color
			asteroidm.z_index = -1
			self.add_child(asteroidm)
			asteroidm.add_to_group("mapPlanets")
			
		
	if runs == 1000:
		
		
		for p in places:
			var label = Label.new()
					
			label.text = "      "+p.name+"   " + String(p.residents.size()) + "  " + p.culture
	#		print((label.text.length()))
			label.visible = false
			label.set_position(p.pos + Vector2((label.text.length()) * -8,20))
	#		label.set_position(p.pos)
			
			label.rect_scale = Vector2(3,3);
	#		label.add_font_override("font", dynamic_font)
			self.add_child(label)
			label.add_to_group("labels")
			var neighb = p.neighbors
			for l in places:
				if neighb.has(l.name):
					if p.pos.distance_to(l.pos) > 200:
						p.neighbors.erase(l.name)
						l.neighbors.erase(p.name)
	
	if !finish && !fullStop && runs > 999:
		unique_factions.clear()
		unique_cultures = [0, 0, 0]
	#
#		t.start(.5)
		clash()
		cleanSim(50)


		for a in get_tree().get_nodes_in_group("mapPlanets"):
			a.queue_free()
		

			
		var offset = 0;
		for p in nodes:
			offset = offset + 1
					
			
			if !unique_factions.has(p.faction):
				unique_factions.append(p.faction + " " + p.culture)
				
			
			if p.culture == "A":
				unique_cultures[0] = unique_cultures[0] + 1
			if p.culture == "F":
				unique_cultures[1] = unique_cultures[1] + 1
			if p.culture == "E":
				unique_cultures[2] = unique_cultures[2] + 1

			
			var asteroidm = PlanetMarker.instance()
			asteroidm.position = p.pos
			asteroidm.scale = Vector2(4,4)
			asteroidm.modulate = p.color
			asteroidm.z_index = -1
			self.add_child(asteroidm)
			asteroidm.add_to_group("mapPlanets")
		logs = "Astrae:" + String(unique_cultures[0]) + ", Facsima:" + String(unique_cultures[1]) + ", Eccles:" + String(unique_cultures[2]) + "\n"+ logs
		print(unique_cultures[0], ", ", unique_cultures[1], ", ",unique_cultures[2])
	for a in get_tree().get_nodes_in_group("lines"):
		conflicts.append(a)
	if unique_cultures.has(2) || unique_cultures.has(1) || unique_cultures.has(0) || collisions > 10:
		if collisions > 10 && collisions < 1000:
			logs =  "Rejected for collisions." + "\n" + logs
			print("Rejected for collisions.")
		finish = true
		
		
		if clashCount < 1 || unique_cultures.has(0):
			logs =  "Rejected for low culture diversity." + "\n"+ logs
			print("Rejected for low culture diversity.")
			collisions = 0
			clashCount = 0
			unique_cultures = [10000,10000,10000];
			unique_factions.clear()
			for a in get_tree().get_nodes_in_group("mapPlanets"):
				a.queue_free()
			for a in get_tree().get_nodes_in_group("labels"):
				a.queue_free()
			finish = false
			build()
		else:
			if !fullStop:
				unique_factions = []
				for faction in unique_factions:
					print(faction)
				fullStop = true
				for p in nodes:
					if !unique_factions.has(p.faction + " " + p.culture):
						unique_factions.append(p.faction + " " + p.culture)
					var asteroidm = PlanetMarker.instance()
					asteroidm.position = p.pos
					asteroidm.scale = Vector2(7,7)
					asteroidm.modulate = p.color
					asteroidm.z_index = -1
					self.add_child(asteroidm)
					asteroidm.add_to_group("mapPlanets")
				labels = get_tree().get_nodes_in_group("labels")
				for i in range(places.size()):
					labels[i].text = "  "+places[i].name+" " + String(places[i].residents.size()) + " " + places[i].culture
					labels[i].visible = false
				for a in get_tree().get_nodes_in_group("lines"):
					conflicts.append(a)
#					a.queue_free()
			else:
				for a in get_tree().get_nodes_in_group("mapPlanets"):
					positions.append(a.position)

				for a in get_tree().get_nodes_in_group("mapPlayer"):
					a.queue_free()
				var Player
				for p in get_tree().get_nodes_in_group("Player"):
					Player = p;
					var pos = (p.position/1000) + Vector2(800,500)
					var asteroidm = PlanetMarker.instance()
					asteroidm.position = pos
					asteroidm.scale = Vector2(4,4)
					asteroidm.modulate = "#ffffff"
					asteroidm.z_index = -1
					self.add_child(asteroidm)
					asteroidm.add_to_group("mapPlayer")
