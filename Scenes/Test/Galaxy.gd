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

var services = [
					"🍲Food",
					"📚Data",
					"📽Mining",
					"⛏️Mechanic",
					"⚙️ShipYard",  
					"Furnace",
					"👚Distillery",
					"Hospital",
					"Police",
					"Bank",
					"Shipping",
					"Theatre"
				]
var levels = [
				"Novice",
				"Adequite",
				"Skilled",
				"Knowledgable",
				"Professional",
				"Master"
			]
			
var skills_compat =   [
						[3,4,18,21],
						[10,11,12,12,14,16,30,31],
						[2, 4, 51],
						[0,1,8,9,57, 53, 60],
						[6, 15, 26, 27,29,43, 58],
						[2, 4, 24, 61, 22],
						[22, 20, 52],
						[22, 12, 35, 36, 39],
						[26, 27, 28, 33, 37, 47, 54, 55],
						[12, 32, 52, 54],
						[2, 14, 15, 30, 31],
						[40, 41,42,43, 48, 49, 50, 18],
					]
					
var FoodSkills = [3,4,18,21]
var DataSkills = [10,11,12,12,14,16,30,31]
var MiningSkills = [2, 4, 29, 61]
var MechanicSkills = [0,1,8,9,57, 53, 60]
var ShipYardSkills = [6, 15, 26, 27,29,43, 58]
var FurnaceSkills = [2, 4, 24, 61, 22]
var DistillarySkills = [22, 20, 52]
var HospitalSkills = [22, 12, 35, 36, 39]
var PoliceSkills = [28, 62]
var BankSkills = [12, 32, 52, 54]
var ShippingSkills = [2, 14, 15, 30, 31]
var TheatreSkills = [40, 41,42,43, 48, 49, 50, 18]

var skills = [
				"Solderer",
				"Machiner",
				"Lifter",
				"Creator",
				"Miner",
				"Visionary",
				"Taste Maker",
				"Designer",
				"Electrician",
				"Engineer",
				"Programmer",
				"Hacker",
				"Analyser",
				"Data Miner",
				"Charter",
				"Pilot",
				"Cartographer",
				"Guide",
				"Comedian",
				"Conversationalist",
				"Brewer",
				"Clothier",
				"Chemist",
				"Cook",
				"Furnace Operator",
				"Crafter",
				"Persuader",
				"Negotiator",
				"Judge of intent",
				"Appraiser",
				"Organizer",
				"Record keeper",
				"Liar",
				"Intimidator",
				"Flatterer",
				"Consoler",
				"Pacifier",
				"Tracker",
				"Student",
				"Observer",
				"Wordsmith",
				"Writer",
				"Poet",
				"Speaker",
				"Leader",
				"Teacher",
				"Fighter",
				"Tactician",
				"Musician",
				"Dancer",
				"Singer",
				"Logician",
				"Mathematician",
				"Optics engineer",
				"Schemer",
				"Gunner",
				"Shield Engineer",
				"Mechanic",
				"Stylist",
				"Armorer",
				"Weapons Specialist",
				"Geologist",
				"Enforcer",
				"Farmer",
				"Theif"
			 ]

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

var num_born = 0;
var num_died = 0

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
	var value = 10000
	var tax_rate = 1.0
	var initial_pop = 0
	var neighbors = []
	var popular = []
	var unpopular = []
	var visitors = []
	var faction = ""
	var color = ""
	var culture = ""
	var piracy_score = 0
	
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
	
	var service_ability = [0,0,0,0,0,0,0,0,0,0,0,0]
	
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
		
	func macro_economize():
		value = value - (100 * piracy_score) + (100 * services.size()) - (10 * residents.size())
		tax_rate = 10000 / value
		
		if value < 8000:
			value = 9000
		
	func new_Node(new_pos, new_mass):
		if !first:
			pos = new_pos
		mass = new_mass
		return self
	
	func check_Services():
		self.service_ability = [0,0,0,0,0,0,0,0,0,0,0,0]
		for r in residents:
			for s in r.service_ability.size():
				self.service_ability[s] = self.service_ability[s] + r.service_ability[s]
		
		var ability_copy = self.service_ability.duplicate()
		services = []
		
		for i in 12:
			var threshhold = 50
			if (residents.size()*2) < 50 && residents.size() > 4:
				threshhold = (residents.size()*2)
			if ability_copy.max() >= threshhold:
				services.append(services_reference[ability_copy.find(ability_copy.max())])
				var n = ability_copy.find(ability_copy.max())
				ability_copy[n] = ability_copy[n] - 100
				
		for p in residents:
			p.business_owner = false
		if residents.size() > 0:
			for s in services:
				for r in services_reference.size():
					var ability_max = 0
					var person = residents[0]
					if services_reference[r] == s:
						for p in residents:
							
							if p.service_ability[r] > ability_max:
								ability_max = p.service_ability[r]
								person = p
						person.business_owner = true
		
	func update():
		var vel = force / mass
		pos = pos + vel
		if pos.x > 1600 || pos.x < 0 || pos.y > 1000 || pos.y < 0:
			pos = pos - vel
		else:
			pass

func getSkill(service_ability):
	randomize()
	var level = randi() % levels.size()
	var skill = randi() % skills.size()
	
	for s in skills_compat.size():
		if skills_compat[s].has(skill):
			service_ability[s] = service_ability[s] + level + 1
	
	
	return levels[level] + " " + skills[skill]
	
class Quest:
	var title = ""
	var type = 0
	var locations_visited = []
	var description = ""
	var reward = 0
	var targets = []
	var shippable = false
	


class Person:
	var name = "example1"
	var service_ability = [0,0,0,0,0,0,0,0,0,0,0,0]
	var age = 0
	var likability = 0
	var business_owner = false
	var wealth = 5000
	var memories = []
	var thoughts = []
	var acquaintances = []
	var annoyances = []
	var friends = []
	var enemies = []
	var lovers = []
	var foes = []
	var family = []
	var knowledge = []
	var skills = []
	var enneagram = [1,4,7]  
	var home = "This Base"
	var travels = []
	var icon = ""
	var boredom = 50
	var happiness = 50
	var culture = ""
	var avatar = 0
	var criminality = 0
	var faction_reputations = []
	var quests = []
	var homestead_candidate = false
	
	
	func _init(new_name,new_age,new_place, new_enneagram, new_culture, new_skills, new_service_ability):
		name = new_name
		age = new_age
		home = new_place
		travels.append(new_place)
		knowledge.append("SpacePort " + new_place)
		enneagram = new_enneagram
		culture = new_culture
		skills = new_skills
		if culture == "F":
			skills.append("Novice Farmer")
		
		for s in skills:
			if s.find("Conversationalist") > -1:
				likability = likability + 1
			if s.find("Comedian") > -1:
				likability = likability + 1
			if s.find("Speaker") > -1:
				likability = likability + 1
			if s.find("Leader"):
				likability = likability + 1
			if s.find("Flatterer") > -1:
				likability = likability + 1
			if s.find("Liar") > -1:
				likability = likability + 1
			if s.find("Schemer") > -1:
				likability = likability - 1
			if s.find("Intimidator") > -1:
				likability = likability - 1
			if s.find("Theif") > -1:
				criminality = criminality + 10
			if s.find("Farmer") > -1:
				homestead_candidate = true
		service_ability = new_service_ability
	
	func generate_quest():
		quests = []
		if travels.size() > 1:
#			collect left behind items
			var q = Quest.new()
		
			if wealth > 1000:
				q.type = 1
				q.title = Array(["Trail of Forgotten Items", "Settling In", "Retrieving Old Goods"])[randi()%3]
				q.locations_visited.append(travels[travels.size()-2])
				if travels.size() > 2:
					q.locations_visited.append(travels[travels.size()-3])
				if travels.size() > 3:
					q.locations_visited.append(travels[travels.size()-4])
				if travels.size() > 4:
					q.locations_visited.append(travels[travels.size()-5])
				q.locations_visited.append(travels[travels.size()-1])
				q.reward = int(100 * q.locations_visited.size() * (wealth/1000))
				q.description = "I've moved around alot due to disagreements with members of other SpacePorts, I think I'm enjoying " + home + " enough to settle down though. Could you return to the previous places I've lived and retrieve some items I had to leave behind?"
			else:
				q.type = 1
				q.title = Array(["Trail of Forgotten Items", "Settling In", "Retrieving Old Goods"])[randi()%3]
				q.locations_visited.append(travels[travels.size()-2])
				if travels.size() > 2:
					q.locations_visited.append(travels[travels.size()-3])
				if travels.size() > 3:
					q.locations_visited.append(travels[travels.size()-4])
				if travels.size() > 4:
					q.locations_visited.append(travels[travels.size()-5])
				q.locations_visited.append(travels[travels.size()-1])
				q.reward = int(50 * q.locations_visited.size())
				q.description = "I've moved around alot looking for consistent work, but I think " + home + " has enough work for me to settle down. Unfortunately, I can't yet afford to retrace my travels and retrieve all the items I had to leave behind. Could you return to the previous places I've lived and retrieve some items I had to leave behind?"
				
			for s in q.locations_visited.size() - 1:
				q.targets.append("Storage")
			q.targets.append(self.name)
			quests.append(q)
#			print(q.title, "\n", q.description, "\n", q.locations_visited, "\n", q.targets, "\n", q.reward)
			pass
			
		if foes.size() > 0:
#			capture a foe
			var q = Quest.new()
			q.type = 2
			q.title = Array(["Retrieving A Foe", "Take Justice Into Your Own Hands", "Revengeful Retrieval", "Old Foe Hunting"])[randi()%4]
			q.description = "The Police are useless and I need an old enemy to pay back some debts. Can you help me?"
			q.reward = 1000
			var foe = foes[randi()%foes.size()]
			var place = ""
			
			
			
			for k in knowledge:
				if k.find("SpacePort") > -1:
					place = k
					place = place.replace("SpacePort ", "")
				if k == foe:
					break
					
			q.description = q.description + " The last place I saw " + foe + " was on " + place + "."

			q.locations_visited.append(place)
			q.locations_visited.append(home)
			q.targets.append(foe)
			q.targets.append(self.name)
			
			quests.append(q)
			
			print(q.title, "\n", q.description, "\n", q.locations_visited, "\n", q.targets, "\n", q.reward)
			
		if service_ability[5] > 5:
#			collect minerals
			pass
			
		if service_ability[6] > 5:
#			collect liquids
			pass
			
		if service_ability[2] > 5:
#			collect liquids and minerals
			pass
			
		if criminality > 5:
#			delivery
			pass
			
		if culture == "F":
#			simple verification mission
			pass
			
		if business_owner:
#			work in that shop
			pass
	
	func survive(services, piracy_score, tax_rate):
		if (age * .000005) > randf():
			self.is_queued_for_deletion()
			print(name, " has died at ", age, " in ", home)
		age = age + .25
		self.wealth = self.wealth * tax_rate
		if(self.wealth < 0):
			self.criminality = self.criminality + 1
			self.happiness = self.happiness - 1
			self.boredom = self.boredom - 1
			self.wealth = self.wealth + (10 * criminality) + (10 * piracy_score)
		if services.has("DiningHall"):
			self.wealth = self.wealth - 10
			self.happiness = self.happiness + 1
		else:
			self.wealth = self.wealth - 50
			self.happiness = self.happiness - 5
		if self.wealth > 400:
			if services.has("Theatre"):
				self.wealth = self.wealth - 50
				self.happiness = self.happiness + 20
				self.boredom = self.boredom - 40
			else:
				self.happiness = self.happiness - 1
				self.boredom = self.boredom + 1
			#Go to the theatre ^^
		if self.wealth > 1000:
			if services.has("Bank"):
				self.wealth = self.wealth*1.03
			else:
				self.wealth = wealth*.98
			

	
	func work(services, service_reference, fellows):
#		print(self.wealth)
#		print(self.service_ability)
#		print(services)
#		print(self.wealth)
		if business_owner:
			self.wealth = self.wealth + (fellows * self.service_ability.max())
		else:
			for s in self.service_ability.size():
				if self.service_ability[s] > 0:
					if services.has(service_reference[s]):
						self.wealth = self.wealth + (10 * self.service_ability[s])
						
						if self.service_ability[s] < 15:
							self.happiness = self.happiness + 10
							self.boredom = self.boredom - 10
							self.service_ability[s] = self.service_ability[s] * 1.01
						else:
							self.happiness = self.happiness + 4
							self.boredom = self.boredom - 5
							for k in self.skills:
								
								if k.find("Novice") > -1:
									k.erase(k.find("Novice"), "Novice".length())
									k = "Master" + k
								if k.find("Adequite") > -1:
									k.erase(k.find("Adequite"), "Adequite".length())
									k = "Master" + k
								if k.find("Skilled") > -1:
									k.erase(k.find("Skilled"), "Skilled".length())
									k = "Master" + k
								if k.find("Knowledgable") > -1:
									k.erase(k.find("Knowledgable"), "Knowledgable".length())
									k = "Master" + k
				else:
					self.happiness = self.happiness - 1
					self.boredom = self.boredom + 1
		pass
		
	



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
	
	randomize()
	var skill_num = randi() %  8 + 2
	var skills = []
	
	var service_ability = [0,0,0,0,0,0,0,0,0,0,0,0]
		
	for i in skill_num:
		skills.append(getSkill(service_ability))
	
	var person = Person.new(name,randi() % 90 + 15,place, pickRandom(enneagramCombos),pculture, skills,service_ability)
	
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
	residents = randi() % 40 + 30
	for i in range(residents):
#		print("hi")
		var p = addRandomCharacter(places[currentplace].name, places[currentplace].culture)
		places[currentplace].residents.append(p);
		for s in places[currentplace].service_ability.size():
			places[currentplace].service_ability[s] = places[currentplace].service_ability[s] + p.service_ability[s]
#		print(places[currentplace].residents[places[currentplace].residents.size()-1].name)

var cultModifier = 20

func interact(i,j, c, place):
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
			i.acquaintances.append(j.name);
			j.acquaintances.append(i.name);
		
		if randi() % 100 == 0 && i.acquaintances.has(j.name):
			i.friends.append(j.name);
			j.friends.append(i.name);
			
		if randi() % 100 == 0 && i.friends.has(j.name):
			i.lovers.append(j.name);
			j.lovers.append(i.name);
			
		if randi() % 100 == 0 && i.lovers.has(j.name):
#			print(place.residents.size())
			var child = addRandomCharacter(i.home, i.culture)
			num_born = num_born + 1
			print("A child named ",child.name," is born! in ",i.home, " ", num_born)
			child.age = randi()%18;
			child.family.append(j.name)
			child.family.append(i.name)
			i.family.append(child.name)
			j.family.append(child.name)
			place.residents.append(child)
#			print(place.residents.size())
			
			
			
			
			
#        console.log(i.name + " is getting along with " + j.name)
		i.likability = i.likability + 1
		i.thoughts.append(i.name+" had a positive experience interacting with "+j.name);
		j.thoughts.append(j.name+" had a positive experience interacting with "+i.name);
		i.happiness = i.happiness + 2;
		j.happiness = j.happiness + 2;

		i.boredom = i.boredom - 2;
		j.boredom = j.boredom - 2;

	elif (enneagramNonCompat[iType-1].has(jType)):
		if (firstTime):
			i.annoyances.append(j.name);
		
		if randi() % 10 == 0 && i.annoyances.has(j.name):
			j.happiness = j.happiness - 5;
			i.enemies.append(j.name);
			
		if randi() % 10 == 0 && i.enemies.has(j.name):
			j.happiness = j.happiness - 10;
			i.foes.append(j.name);

			
		
#		console.log(i.name + " is annoyed by " + j.name)
		j.likability = j.likability - 1
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

func genStep(skipper = false):
	places[currentplace].check_Services()
	places[currentplace].macro_economize()
	for c in places[currentplace].residents:
#		print(c.name)
		c.survive(places[currentplace].services, places[currentplace].piracy_score, places[currentplace].tax_rate)
		c.work(places[currentplace].services, places[currentplace].services_reference, places[currentplace].residents.size())
		interact(c, pickRandom(places[currentplace].residents), places[currentplace].culture,places[currentplace]);
		if !skipper:
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
			for i in places[currentplace].service_ability.size():
				places[currentplace].service_ability[i] = places[currentplace].service_ability[i] - nomad.service_ability[i]
			nomad.wealth = nomad.wealth - 100
			newBase(nomad);
			stop = false;
		else:
			genStep();

func findPlaceByName(placeName):
	for i in range(places.size()):
		if(places[i].name == placeName):
			return i;
		
func cleanStep(residents, cult, place):
	for c in residents:
		if(!stop):
			interact(c, pickRandom(residents), cult, place);
			if(c.happiness<30 or c.boredom>100):
				nomad = c;
				nomad.wealth = nomad.wealth - 100
				stop = true;
			elif(c.happiness>3000 or c.boredom<-3000):
				nomad = c;
				nomad.wealth = nomad.wealth - 100
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
				nomad.wealth = nomad.wealth - 100
				

				places[findPlaceByName(newHome)].residents.append(nomad);
				var index = p.residents.find(nomad);
				p.residents.pop_at(index);
				for n in p.service_ability.size():
					p.service_ability[n] = p.service_ability[n] - nomad.service_ability[n]
				for n in places[findPlaceByName(newHome)].service_ability.size():
					places[findPlaceByName(newHome)].service_ability[n] = places[findPlaceByName(newHome)].service_ability[n] + nomad.service_ability[n]
				stop = false;
			
			cleanStep(p.residents, p.culture, p)
			
func getRandomColor():
	var letters = '0123456789ABCDEF';
	var color = '#';
	for i in range(6):
		color += letters[randi()%12 + 4];
	return color;


var noNodes = 100;
var noConn = 50;
var gravityConstant = 5.1;
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
				line.add_to_group("conflictlines")
				
				
				
				if(attackerMight > defenderMight):
					places[index].faction = e.faction;
					places[index].color = e.color;
					places[index].culture = e.culture;

		   
#var t = Timer.new()

var size = 180;

var finish = false

var collisions = 0;

func getNodes() -> Array:
	return nodes
var mass = 200
var spacing = 100;
var price_count = 0
var queue = []
var price = 999999
var pre_price = 9999999999999
func TSPNearestNeighbor(nodes):
	price = 0
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
		price = price + matrix[temp].min()
		matrix[pre_temp][temp] = 99999999999
		matrix[temp][pre_temp] = 99999999999
		soln.append(nodes[temp])
		for i in matrix_width:
			matrix[i][temp] = 99999999999

#	for n in matrix_width:
#		print(matrix[n])

	return soln

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
		p.check_Services()
		var pos = Vector2(randi()%1600, randi()%1000)
		nodes.append(p.new_Node(pos, mass))
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
	price = 999999999999999
	pre_price = 9999999999999999
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
func array_unique(array: Array) -> Array:
	var unique: Array = []

	for item in array:
		if not unique.has(item):
			unique.append(item)

	return unique
	
var TSPruns = 0

var context = ""
var personcontext = ""

func _process(delta):
	
	var individual 

	var labels = get_tree().get_nodes_in_group("labels")
	
	runs = runs + 1
	
	if (runs % 5000) == 0:
		for a in get_tree().get_nodes_in_group("labels"):
			a.queue_free()
		print("updated")
		for p in nodes:
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
	
	
	if nodes.size() < 5:
		runs = 2000
		
	
	
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
			
		
#	if runs == 1000:
#
#
#		for p in places:
#			var label = Label.new()
#
#			label.text = "      "+p.name+"   " + String(p.residents.size()) + "  " + p.culture
#	#		print((label.text.length()))
#			label.visible = false
#			label.set_position(p.pos + Vector2((label.text.length()) * -8,20))
#	#		label.set_position(p.pos)
#
#			label.rect_scale = Vector2(3,3);
#	#		label.add_font_override("font", dynamic_font)
#			self.add_child(label)
#			label.add_to_group("labels")
#			var neighb = p.neighbors
#			for l in places:
#				if neighb.has(l.name):
#					if p.pos.distance_to(l.pos) > 200:
#						p.neighbors.erase(l.name)
#						l.neighbors.erase(p.name)
	
	if !finish && !fullStop && runs > 999:
		unique_factions.clear()
		unique_cultures = [0, 0, 0]
	#
#		t.start(.5)
		clash()
		cleanSim(5)


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
	conflicts.clear()
	for a in get_tree().get_nodes_in_group("conflictlines"):
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
#				labels = get_tree().get_nodes_in_group("labels")
#				for i in range(places.size()):
#					labels[i].text = "  "+places[i].name+" " + String(places[i].residents.size()) + " " + places[i].culture
#					labels[i].visible = false
				for a in get_tree().get_nodes_in_group("lines"):
					conflicts.append(a)
#					a.queue_free()
			else:

				if TSPruns < 1000:
					var places = []
					for a in get_tree().get_nodes_in_group("mapPlanets"):
						places.append(a.position)
					places.shuffle()
					var route = TSPNearestNeighbor(places)
					TSPruns = TSPruns + 1
					
					var line = Line2D.new()

					line.width = 4
					
					
					var no_dupe_route = array_unique(route)

					for r in no_dupe_route:
						line.add_point(r)
					line.add_point(no_dupe_route[0])
						
					for p in line.points.size() - 1:
						price = price + line.points[p].distance_to(line.points[p+1])
					
					price_count = price_count + 1
					if price < pre_price:
						print(price, " ", price_count)
						pre_price = price
						for a in get_tree().get_nodes_in_group("lines"):
							a.queue_free()
						
						add_child(line)
						line.add_to_group("lines")
						queue = []
						for l in line.points:
							queue.append((l - Vector2(800, 500)) * 1000)
							
#						print("Some context on the universe: ")
						
#						context = "Some context on the universe: "
#
#						for n in nodes:
#							context = context + n.name+ " is a location with "+ String(n.residents.size()) + " residents. It has the following services: "+ String(n.services)+ "and is of the faction: "+ n.faction
##							print(n.name, " is a location with ", n.residents.size(), " residents. It has the following services: ", n.services, "and is of the faction: ", n.faction)
#
##						individual = nodes[randi()% nodes.size()].residents[0]
#
#						personcontext = "You are " + individual.name + " from " + individual.home +" Answer as, " + individual.name + ", the assistant, only. "
#						personcontext = personcontext + "You are a "
#						for s in individual.skills:
#							personcontext = personcontext + s + ", "
#						personcontext = personcontext + "."
#
#						personcontext = personcontext + "You know "
#						for k in individual.knowledge:
#							personcontext = personcontext + k + ", "
#						personcontext = personcontext + "."

					else:
						line.queue_free()
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
