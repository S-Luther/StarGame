extends KinematicBody2D


export var ACCELERATION = 600
export var MAX_SPEED = 800

export var ROLL_SPEED = 10
export var FRICTION = 1

var colCheckTimer = Timer.new();

enum {
	MOVE,
	FALL,
	ATTACK,
	HIT
}

var hearts = 4

var i = 0

var state = ATTACK
var velocity2 = Vector2.ZERO
var roll_vector = Vector2.DOWN
var init = false
var smooth_angle = -1.6;

onready var nav = $Engine/NavTerminal/
onready var minimap = $Engine/NavTerminal/UI/
onready var player1 = $Engine/Player1
onready var engine = $Engine
var timer = Timer.new()
onready var animationPlayer = $Engine/Visible/AnimationPlayer

const projectile = preload('res://Scenes/Shared/Projectile.tscn')

onready var speedLabel = $Speed 

var workable = false
var working = false
var prevelocity = Vector2()

var has_collided = false;

func _ready():
	self.add_child(timer)
	self.add_child(colCheckTimer)
	colCheckTimer.one_shot = true
	colCheckTimer.start(.2)
	randomize()
	self.add_to_group("Player")
	set_process(true)

var toggle = true

func _process(delta):
	update()
	
	var overview;
	var Player
	for o in get_tree().get_nodes_in_group("OverView"):
		overview = o
	for p in get_tree().get_nodes_in_group("Player"):
		Player = p
		
	if get_tree().get_nodes_in_group("FarmCam").size() > 0:
		if get_tree().get_nodes_in_group("FarmCam")[0].current:
			if toggle:
				var life = get_tree().get_nodes_in_group("life")[0]
				var new_life = life.hearts + .25;
				life.set_hearts(new_life)
				velocity2 = Vector2.ZERO
				self.position = self.position + Vector2(1500,0)
				toggle = false
	if get_tree().get_nodes_in_group("cam")[0].current:
		toggle = true
	
	if get_tree().get_nodes_in_group("SpacePortCamera").size() > 0:
		if get_tree().get_nodes_in_group("SpacePortCamera")[0].current:
			if toggle:
				var life = get_tree().get_nodes_in_group("life")[0]
				var new_life = life.hearts + .25;
				life.set_hearts(new_life)
				velocity2 = Vector2.ZERO
				self.position = self.position + Vector2(1500,0)
				toggle = false
	if get_tree().get_nodes_in_group("cam")[0].current:
		toggle = true
	
	if colCheckTimer.is_stopped():
		if has_collided:
			var life = get_tree().get_nodes_in_group("life")[0]
			var new_life = life.hearts - .25;
			life.set_hearts(new_life)
			var mainCam = get_tree().get_nodes_in_group("cam")[0]
			mainCam.apply_shake()
			var cams = get_tree().get_nodes_in_group("OverViewCamera")
			if(cams.size() > 0):
				if cams[0].current:
					overview.visible = !overview.visible
					Player.visible = !Player.visible
					cams[0].current = !cams[0].current
					mainCam.current = !mainCam.current
		has_collided = false;
		colCheckTimer.start(.2)

	if player1.position.x >100 || player1.position.x<-100 || player1.position.y >100 || player1.position.y<-100 :
		player1.position = Vector2.ZERO
	if timer.is_stopped():
		init = true
	
	if workable:
		if !working && Input.is_action_just_pressed("p1_swing"):
			working = true
			state = MOVE
			
		elif working && Input.is_action_just_pressed("p1_swing"):
			state = ATTACK
			working = false
			nav.crash()
	match state:
		MOVE:
			move_state(delta)
		ATTACK:
			attack_state(delta)
		

static func lerp_angle(a, b, t):
	if abs(a-b) >= PI:
		if a > b:
			a = normalize_angle(a) - 2.0 * PI
		else:
			b = normalize_angle(b) - 2.0 * PI
	return lerp(a, b, t)


static func normalize_angle(x):
	return fposmod(x + PI, 2.0*PI) - PI


func move_state(delta):

	if working && workable:
		if Input.is_action_just_pressed("p1_fire"):
			var p = projectile.instance()
			p.position = engine.position
			p.velocity = Vector2(15, 0).rotated(smooth_angle)
			p.rotation = smooth_angle
			p.z_index = 2
			p.scale = Vector2(2,2)
			add_child(p)
			p.add_to_group("shots")
			
		
		if player1.position.x < 40:
			working = false
			workable = false
		var input_vector = Vector2.ZERO
		input_vector.x = Input.get_action_strength("p1_left") - Input.get_action_strength("p1_right")
		input_vector.y = Input.get_action_strength("p1_up") - Input.get_action_strength("p1_down")

		input_vector = input_vector.normalized()

		
		if input_vector != Vector2.ZERO:
			##print(velocity2)
			###print(rad2deg(input_vector.angle()))
			animationPlayer.play("Pulse")
			var target_angle = input_vector.angle()
			

			var lerp_speed = 5.0
			smooth_angle = lerp_angle(engine.transform.get_rotation(), target_angle, delta*lerp_speed)

			engine.rotation = smooth_angle
			
			player1.rotation = -smooth_angle
			minimap.rotation = -smooth_angle + -PI/2
			
			if player1.position.x > 55:
				player1.position = player1.position + Vector2(-1,-0)
			if player1.position.x < 65:
				player1.position = player1.position + Vector2(1,-0)
			
			roll_vector = input_vector
			###print("Vector2" , input_vector, ",")
			
			velocity2 = velocity2.move_toward(input_vector * MAX_SPEED, ACCELERATION * delta)
			#state = ROLL
		else:

			animationPlayer.play("StopStart")

			###print("Vector2" , input_vector, ",")
			

			velocity2 = velocity2.move_toward(Vector2.ZERO, FRICTION * delta)
			#state = ATTACK
		
		move()

#		draw_line(A, B, Color(1,1,1), 3)
	else: 
		state = ATTACK
		working = false
	

func attack_state(delta):
	velocity2 = velocity2
	velocity2 = velocity2.move_toward(Vector2.ZERO, FRICTION * delta)
	animationPlayer.play("StopStart")

	move()
var collisions = 0;
func move():
	##print(velocity2)

	velocity2 = move_and_slide(velocity2)
#	collisions = collisions + 1
#	for i in get_slide_count():
#		var collision = get_slide_collision(i)
#		has_collided = true;
#		if collision.get_collider() is KinematicBody2D:
##			print("Collided with: ", collision.get_collider())
#			collision.get_collider().hit()
#		print("Collided with: ", collisions)

func slice():
	pass

func crash():
	player1.crash()
	nav.crash()
	workable = false
#	working = false
#	state = ATTACK
	#print("crash")

func _on_Helm_area_entered(area):
	workable = true
	#print("helm on")


func _on_Helm_area_exited(area):
	#print("turn off heml")
	workable = false

func hit():
	pass


#func _on_Engine_area_entered(area):
#	if area.name == "LeftBounds":
#		if init:
#			##print(area)
#			velocity2 = Vector2(689, 0)
#			move()
#			crash()
#	elif area.name == "RightBounds":
#		if init:
#			##print(area)
#			velocity2 = Vector2(-689, 0)
#			move()
#			crash()
#	elif area.name == "TopBounds":
#		if init:
#			##print(area)
#			velocity2 = Vector2(0,689)
#			move()
#			crash()
#	elif area.name == "BottomBounds":
#		if init:
#			##print(area)
#			velocity2 = Vector2(0,-689)
#			move()
#			crash()


var hits = 0


func _on_Area2D_body_entered(body):
#	print(body) # Replace with function body.
	if body is KinematicBody2D:
		if hits < 2:
			hits = hits + 1
		else:
			has_collided = true;
#			print("Collided with: ", collision.get_collider())
		body.hit()
