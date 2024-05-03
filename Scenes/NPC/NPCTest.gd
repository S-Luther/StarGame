extends KinematicBody2D

func _ready():
	pass # Replace with function body.
	


var velocity = Vector2.ZERO
var collisions = 0
var has_collided = false
var details
var NPC = true
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	velocity = move_and_slide(velocity)
	collisions = collisions + 1
	for i in get_slide_count():
		var collision = get_slide_collision(i)
		has_collided = true;
		if collision.get_collider() is KinematicBody2D && collision.get_collider().NPC != true:
			print("Collided with: ", collision.get_collider())
			print(details.name, " ", details.age)
			get_parent().interact(details)
