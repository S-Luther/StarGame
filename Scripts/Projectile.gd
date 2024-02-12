extends KinematicBody2D

var spawnDuration = Timer.new()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var velocity = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(spawnDuration)
	spawnDuration.one_shot = true
	spawnDuration.start(4)
	print(spawnDuration.time_left)
	set_process(true)

	
func _process(delta):
	move_and_collide(velocity)
	if spawnDuration.is_stopped():
		queue_free()


