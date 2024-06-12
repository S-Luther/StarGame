extends "res://Scripts/LancerDrone.gd"

var passengers = []



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
			print("moved ", p.person.name, " to ", place.name)
			p.person.happiness = 50
			p.person.boredom = 50
			place.residents.append(p.person)
			passengers.erase(p)
			
	if passengers.size() < 24:
		for r in residents:
			if r.happiness<10 || r.boredom>100:
				if passengers.size() < 24:
					var destination = places[randi()%places.size()]
					var dest_pos = destination.pos - Vector2(800, 500)
					dest_pos = dest_pos * 1000
					while dest_pos == pos:
						randomize()
						destination = places[randi()%places.size()]
						dest_pos = destination.pos - Vector2(800, 500)
						dest_pos = dest_pos * 1000
					print("Picked up: ", r.name)
					place.residents.erase(r)
					passengers.append(Passenger.new(dest_pos, r))
					
	
func _process(delta):
	if near_something:
		for p in places:
			var pos = p.pos - Vector2(800, 500)
			pos = pos * 1000
			if pos.distance_to(self.position) < 3000:
	#			print("Bus Stop Reached")
				process_location(p)
	if passengers.size() > 25:
		print(passengers.size())
		
