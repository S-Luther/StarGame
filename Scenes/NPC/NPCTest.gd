extends KinematicBody2D

var rng = RandomNumberGenerator.new()
var randomnum
var target

var changeTarget = Timer.new()
var socialCooldown = Timer.new()

func _ready():
	self.add_child(changeTarget)
	changeTarget.one_shot = true
	changeTarget.start(5)
	self.add_child(socialCooldown)
	socialCooldown.one_shot = true
	socialCooldown.start(2)
	randomnum = rng.randf()
	target = get_circle_position()
	pass # Replace with function body.
	


var velocity = Vector2.ZERO
var collisions = 0
var has_collided = false
var details
var NPC = true
var SPEED = 4

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if changeTarget.is_stopped():
		changeTarget.start(randi()%50)
		target = get_circle_position()
	velocity = move_and_slide(velocity)
	collisions = collisions + 1
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		has_collided = true;
		if collision.get_collider() is KinematicBody2D && collision.get_collider().NPC != true:

			get_parent().interact(details)
		elif collision.get_collider() is KinematicBody2D && collision.get_collider().NPC:
			if socialCooldown.is_stopped():
				interact(details, collision.get_collider().details)
				socialCooldown.start(5)
			

	move(target, delta)

func move(target, delta):
	
	var direction = (target - global_position).normalized() 
	var desired_velocity =  direction * SPEED
	var steering = (desired_velocity - velocity) * delta * .5
	velocity += steering

	self.rotation = velocity.angle()
	var collision = move_and_collide(velocity/10)

func get_circle_position():
	rng.randomize()
	return Vector2(rng.randi()% 1800, rng.randi() % 2000)




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

func interact(i,j):
	print("interacting")
	var iType = i.enneagram[randi()%3];
	var jType = j.enneagram[randi()%3];
	
	var firstTime = false;
	
	
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
	
