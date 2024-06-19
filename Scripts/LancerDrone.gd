extends KinematicBody2D

var SPEED = 50
var MAX = 1000

var attacker = false

var attack_timer = Timer.new()
var pause_timer = Timer.new()
var move_timer = Timer.new()
var collision_timer = Timer.new()
var regen_timer = Timer.new()
const projectile = preload('res://Scenes/Shared/Projectile.tscn')
onready var animationPlayer = $AnimationPlayer
onready var collision = $CollisionShape2D

var health = .5;
var origin_health = 0


var trailer = false
var pre_target = null
var origin = null
var dest_index = 0
var queue = []

var near_something = false

var velocity = Vector2.ZERO

var player
var places = []

var alive = true

var randomnum
var swp = false

enum {
	SURROUND,
	ATTACK,
	HIT,
	SLICE
}
var rng = RandomNumberGenerator.new()
var state = SURROUND
var angle = 1.5

func _ready():
	self.add_to_group("baddies")
	rng.randomize()
	randomnum = rng.randf()
	self.add_child(attack_timer)
	attack_timer.one_shot = true
	attack_timer.start(2)
	self.add_child(pause_timer)
	pause_timer.one_shot = true
	self.add_child(move_timer)
	move_timer.one_shot = true
	self.add_child(collision_timer)
	collision_timer.one_shot = true
	collision_timer.start(2)
	self.add_child(regen_timer)
	regen_timer.one_shot = true
	regen_timer.start(15)
	origin_health = health
	

	
	

	
var runs = 0
var paused = false
func _physics_process(delta):
	if regen_timer.is_stopped():
		if health < origin_health:
			print("regen: ", health)
			health = health + .5
		regen_timer.start(15)
		
	if !paused:
		runs = runs + 1
		if runs % 10 == 0:
			if(self.global_position.distance_to(get_tree().get_nodes_in_group("player")[0].global_position)>4000):
	#			self.modulate.s = 100
				collision.disabled = true
			else:
	#			self.modulate.s = 0
				collision.disabled = false
		
	#	print((self.velocity - get_tree().get_nodes_in_group("player")[0].global_position).angle(), " - ", self.velocity.angle())


	#

		if attack_timer.is_stopped():
			var upper = abs(rad2deg(get_tree().get_nodes_in_group("player")[0].global_position.angle_to_point(self.global_position))) + 15
			var lower = abs(rad2deg(get_tree().get_nodes_in_group("player")[0].global_position.angle_to_point(self.global_position)))  - 15

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
	#			pass
				if alive && attacker:
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
				health = health - 1
				if(health < 0):
					alive = false
					velocity = Vector2.ZERO
					animationPlayer.play("Hit")
			SLICE:
				health = health - 10
				if(health < 0):
					alive = false
					velocity = Vector2.ZERO
					animationPlayer.play("Slice")
			
	self.modulate.s = 0

func move(target, delta):
	
	
	
	if move_timer.is_stopped():
		
		if(self.position.distance_to(target) < 3000): 
#			emit_signal("target reached")

			if queue.size() > 0:
#				print(dest_index)
				dest_index = dest_index + 1
				if dest_index >= queue.size():
					dest_index = 0
#				print(dest_index)
				pre_target = queue[dest_index];
			else:
				var temp = pre_target
				pre_target = origin
				origin = temp
			
		if(self.position.distance_to(target) < 4000):
			near_something = true
		else:
			near_something = false
		
		var direction = (target - global_position).normalized() 
		var desired_velocity =  direction * SPEED
		var steering = (desired_velocity - velocity) * delta * .1
		velocity += steering

		self.rotation = velocity.angle()
		move_and_slide(velocity*delta*MAX)

		
		if get_slide_count() > 0:
#			print(collision.collider)

			if collision_timer.is_stopped():
				swp = !swp
				collision_timer.start(1)
#				if swp:
				angle = angle + PI * randf()
#				else:
#					angle = -PI * randf()
#				print(angle)
#				print("tripped")
				move_timer.start(1)
				hit()
				
	else:
#		print("turning")
		if(self.position.distance_to(target) < 2000): 

#			emit_signal("target reached")
			if queue.size() > 0:
				print(dest_index)
				dest_index = dest_index + 1
				if dest_index >= queue.size():
					dest_index = 0
				print(dest_index)
				pre_target = queue[dest_index];
				
			else:
				var temp = pre_target
				pre_target = origin
				origin = temp
		if(self.position.distance_to(target) < 3000):
			near_something = true
		else:
			near_something = false
		
		var direction = (target - global_position).normalized() 
		
		direction = direction.rotated(angle)
		
		var desired_velocity =  direction * SPEED
		
		var steering = (desired_velocity - velocity) * delta * .1
		velocity += steering


		self.rotation = velocity.angle()
		move_and_slide(velocity*delta*MAX)
		

		


func hit_animation_finished():
	queue_free()

func slice_animation_finished():
	queue_free()
	
func hit():
	animationPlayer.play("strike")
	self.modulate.s = 100
	health = health - 1
	if(health < 0):
		alive = false
		velocity = Vector2.ZERO
		animationPlayer.play("Hit")

	
func slice():
	animationPlayer.play("strike")
	self.modulate.s = 100
	health = health - 1
	if(health < 0):
		alive = false
		velocity = Vector2.ZERO
		animationPlayer.play("Slice")

	
func get_circle_position(random):
	var kill_circle_centre = Vector2.ZERO
	if pre_target == null:
		kill_circle_centre = get_tree().get_nodes_in_group("player")[0].global_position
	else:
		kill_circle_centre = pre_target
	var radius = 100
	 #Distance from center to circumference of circle
	var angle = random * PI * 2;
	var x = kill_circle_centre.x + cos(angle) * radius;
	var y = kill_circle_centre.y + sin(angle) * radius;

	return Vector2(x, y)


func _on_AttackTimer_timeout():
	rng.randomize()
	state = ATTACK


func _on_Area2D_area_entered(area):
	if collision_timer.is_stopped():
		collision_timer.start(4)
		angle = 1.5 + randf()
#		print(angle)
#		print("special")
#				print("tripped")
		move_timer.start(2)
