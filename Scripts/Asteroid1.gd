extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var particles = $CPUParticles2D
onready var sprite = $Sprite
onready var c2 = $Asteroid2
onready var c1 = $Asteroid
onready var c3 = $Asteroid3
onready var c4 = $Asteroid4

var mined = false
var first = false

var velocity = Vector2()


func ready():
	pass
		
func _physics_process(delta):
	if mined:
		
		self.position = self.position.linear_interpolate(get_tree().get_nodes_in_group("player")[0].global_position, .08)
		
		if(self.position.distance_to(get_tree().get_nodes_in_group("player")[0].global_position)<100):
			self.queue_free()
			print(particles.color)
			if(String(particles.color) == "0.713726,0.380392,0.109804,1"):
				print("found mineral")
				get_tree().get_nodes_in_group("player")[0].minerals = get_tree().get_nodes_in_group("player")[0].minerals + 50
				print(get_tree().get_nodes_in_group("player")[0].minerals)
			if(String(particles.color) == "0,0.039216,0.670588,1" || String(particles.color) == "0,0.258824,0.662745,1"):
				print("found liquid")
				get_tree().get_nodes_in_group("player")[0].liquids = get_tree().get_nodes_in_group("player")[0].liquids + 50
				print(get_tree().get_nodes_in_group("player")[0].liquids)
#	if t.is_stopped() && mined:
#		self.queue_free()

#	particles.gravity = get_tree().get_nodes_in_group("player")[0].global_position
#	move_and_collide(velocity)
	
	pass
	
func hit():
	pass
		
func slice():
	if !first:
		first = true
		particles.emitting = true
		mined = true
		sprite.queue_free()
		c1.queue_free()
		c2.queue_free()
		c3.queue_free()
		c4.queue_free()
	
	


