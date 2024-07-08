extends "res://Scripts/LancerDrone.gd"

var passengers = []

var currentIndex = 0

class Passenger:
	var destination = Vector2.ZERO
	var person = null
	
	func _init(dest, pers):
		destination = dest
		person = pers
	
func process_location(place):
	var residents = place.residents
	var pos = place.pos - Vector2(800, 500)
	pos = pos * 1000
	
	for p in passengers:
		if p.destination == pos:
			p.person.travels.append(place.name)   
			p.person.home = place.name
			print("moved ", p.person.name, " to ", place.name)
			p.person.happiness = 50
			p.person.boredom = 50
			place.residents.append(p.person)
			for s in place.service_ability.size():
				place.service_ability[s] = place.service_ability[s] + p.person.service_ability[s]
			passengers.erase(p)

			
	if passengers.size() < 24:
		for r in residents:
			if r.happiness<0 || r.boredom>100:
				if r.wealth > 400:
					if passengers.size() < 24:
						randomize()
	#					print("CI: ", currentIndex)
						var offset = 1 + (randi()%2)
						var next_stop =  (currentIndex + offset) % queue.size()
	#					print("Guess: ", next_stop)
						r.wealth = r.wealth - (offset * 50)
						var destination
						for p in places:
							var posi = p.pos - Vector2(800, 500)
							posi = posi * 1000
							if posi == queue[next_stop]:
								destination = p
	#							print("found")

						var dest_pos = destination.pos - Vector2(800, 500)
						dest_pos = dest_pos * 1000
	#					while dest_pos == pos:
	#						randomize()
	#						destination = places[randi()%places.size()]
	#						dest_pos = destination.pos - Vector2(800, 500)
	#						dest_pos = dest_pos * 1000
						print("Picked up: ", r.name, " from ", place.name)
						place.residents.erase(r)
						for s in place.service_ability.size():
							place.service_ability[s] = place.service_ability[s] - r.service_ability[s]
						passengers.append(Passenger.new(dest_pos, r))
					
	
func _process(delta):
	if near_something:
		for p in places:
			var pos = p.pos - Vector2(800, 500)
			pos = pos * 1000
			if pos.distance_to(self.position) < 3000:
				currentIndex = queue.find(pos)
	#			print("Bus Stop Reached")
				process_location(p)
	if passengers.size() > 25:
		print(passengers.size())
		
