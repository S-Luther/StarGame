extends KinematicBody2D

var SPEED = 50

var attack_timer = Timer.new()
var pause_timer = Timer.new()
const projectile = preload('res://Scenes/Shared/Projectile.tscn')
onready var animationPlayer = $AnimationPlayer

var velocity = Vector2.ZERO

var player

var randomnum

enum {
	SURROUND,
	ATTACK,
	HIT,
}
var rng = RandomNumberGenerator.new()
var state = SURROUND

func _ready():
	rng.randomize()
	randomnum = rng.randf()
	self.add_child(attack_timer)
	attack_timer.one_shot = true
	attack_timer.start(2)
	self.add_child(pause_timer)
	pause_timer.one_shot = true
	
	

	

func _physics_process(delta):
	if attack_timer.is_stopped():
		attack_timer.start(4)
		rng.randomize()
		randomnum = rng.randf()
		state = ATTACK
	
	match state:
		SURROUND:
			move(get_circle_position(randomnum), delta)
		ATTACK:
#			var p = projectile.instance()
#			p.position = global_position
#			p.velocity = Vector2(10, 0).rotated(velocity.angle())
#			p.rotation = velocity.angle()
#			p.z_index = 2
#			p.scale = Vector2(2,2)
#			add_child(p)
#			p.add_to_group("shots")

			state = SURROUND


		HIT:
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
