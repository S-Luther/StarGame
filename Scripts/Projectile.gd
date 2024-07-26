extends KinematicBody2D

class_name Projectile

var spawnDuration = Timer.new()
var activeWait = Timer.new()
var NPC = true
var originator = null

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO

onready var animationPlayer = $Area2D/Sprite/ProjectilePlayer
onready var collider = $CollisionShape2D
onready var plasma = $plasma

var hashit = false
var hitspot = Vector2.ZERO
#onready var animationTree = $Sprite/ProjectileTree
#onready var animationState = animationTree.get('parameters/playback')

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(activeWait)
	activeWait.one_shot = true
	activeWait.start(.1)
	self.add_child(spawnDuration)
	spawnDuration.one_shot = true
	spawnDuration.start(4)
	plasma.play() 
#	print(spawnDuration.time_left)
	set_process(true)

var done = false
	
	
func _process(delta):
	if hashit:
		self.global_position = hitspot
	var collision = move_and_collide(velocity,false)
	if collision:
		hitspot = self.global_position
#		collider.disabled = true;
		hashit = true
		velocity = Vector2.ZERO
		animationPlayer.play("Hit")
		

		
#		queue_free()
	
	if spawnDuration.is_stopped():
		queue_free()
	if activeWait.is_stopped() && !done:
		done = true
		collider.disabled = false;

func hit():
	velocity = Vector2.ZERO
	animationPlayer.play("Hit")
	collider.disabled = true;
	
func slice():
	collider.disabled = true;
	velocity = Vector2.ZERO
	animationPlayer.play("Hit")

func hit_animation_finished():
	queue_free()

func _on_Area2D_area_entered(area):
	pass
