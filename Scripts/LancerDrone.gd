extends KinematicBody2D

var SPEED = 50

var attack_timer = Timer.new()
var pause_timer = Timer.new()
const projectile = preload('res://Scenes/Shared/Projectile.tscn')
onready var animationPlayer = $AnimationPlayer

var velocity = Vector2.ZERO

var player

var alive = true

var randomnum

enum {
	SURROUND,
	ATTACK,
	HIT,
}
var rng = RandomNumberGenerator.new()
var state = SURROUND

func _ready():
	self.add_to_group("baddies")
	rng.randomize()
	randomnum = rng.randf()
	self.add_child(attack_timer)
	attack_timer.one_shot = true
	attack_timer.start(2)
	self.add_child(pause_timer)
	pause_timer.one_shot = true
	
	

	

func _physics_process(delta):
#	print((self.velocity - get_tree().get_nodes_in_group("player")[0].global_position).angle(), " - ", self.velocity.angle())
	var upper = abs(rad2deg(get_tree().get_nodes_in_group("player")[0].global_position.angle_to_point(self.global_position))) + 15
	var lower = abs(rad2deg(get_tree().get_nodes_in_group("player")[0].global_position.angle_to_point(self.global_position)))  - 15


#

	if attack_timer.is_stopped():
		attack_timer.start(1)
		rng.randomize()
		randomnum = rng.randf()
#		print("(", lower, ", ", upper, ")", " - ", rad2deg(self.velocity.angle()))
		if abs(rad2deg(self.velocity.angle())) > lower:
#			print("one ", rad2deg(self.velocity.angle()), " > ", lower)
			if abs(rad2deg(self.velocity.angle())) < upper:
#				print("two ", rad2deg(self.velocity.angle()), " < ", upper)
				if self.global_position.distance_to(get_tree().get_nodes_in_group("player")[0].global_position) < 1500:
					if self.global_position.distance_to(get_tree().get_nodes_in_group("player")[0].global_position) > 500:
						state = ATTACK


	
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
			if alive:
	#			print("boom")
				var p = projectile.instance()
				p.position = Vector2(self.position.x, self.position.y)
				p.velocity = Vector2(20, 0).rotated(velocity.angle())
				p.rotation = velocity.angle()
				p.z_index = 2
				p.scale = Vector2(1,1)
				get_tree().get_root().add_child(p)
				p.add_to_group("shots")
			state = SURROUND


		HIT:
			alive = false
			velocity = Vector2.ZERO
			animationPlayer.play("Hit")
	

func move(target, delta):
	
	var direction = (target - global_position).normalized() 
	var desired_velocity =  direction * SPEED
	var steering = (desired_velocity - velocity) * delta * .5
	velocity += steering

	self.rotation = velocity.angle()
	var collision = move_and_collide(velocity/10)
	if collision:
		state = HIT

		


func hit_animation_finished():
	queue_free()
	
func hit():
	state = HIT
	velocity = Vector2.ZERO

	
func get_circle_position(random):
	var kill_circle_centre = get_tree().get_nodes_in_group("player")[0].global_position
	var radius = 1000
	 #Distance from center to circumference of circle
	var angle = random * PI * 2;
	var x = kill_circle_centre.x + cos(angle) * radius;
	var y = kill_circle_centre.y + sin(angle) * radius;

	return Vector2(x, y)


func _on_AttackTimer_timeout():
	rng.randomize()
	state = ATTACK
