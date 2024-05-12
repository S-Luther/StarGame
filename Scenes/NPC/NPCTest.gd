extends KinematicBody2D

var rng = RandomNumberGenerator.new()
var randomnum
var target

var changeTarget = Timer.new()

func _ready():
	self.add_child(changeTarget)
	changeTarget.one_shot = true
	changeTarget.start(5)
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
			print("Collided with: ", collision.get_collider())
			print(details.name, " ", details.age)
			get_parent().interact(details)
			

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
