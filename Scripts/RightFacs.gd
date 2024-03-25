extends Area2D


enum {
	MOVE,
	ROLL,
	ATTACK,
	HIT
}

const projectile = preload('res://Scenes/Shared/FacsProjectile.tscn')


var i = 0

var state = ATTACK


var workable = false
var working = false

var prefix = ""

var AngleOffset = 0.0

onready var gun = $GunRight

var ROLL_SPEED = 0.05



func _ready():
	randomize()



func _process(delta):

	if workable:
		if !working && Input.is_action_just_pressed(prefix+"_swing"):
			working = true
			state = MOVE
			
		elif working && Input.is_action_just_pressed(prefix+"_swing"):
			state = ATTACK
			working = false
	match state:
		MOVE:
			move_state()
		ATTACK:
			attack_state()
		
var input_vector = Vector2.ZERO

func move_state():
	
	input_vector.x = Input.get_action_strength(prefix+"_right") - Input.get_action_strength(prefix+"_left")
	input_vector.y = Input.get_action_strength(prefix+"_down") - Input.get_action_strength(prefix+"_up")
	if abs(fmod(gun.rotation, 2*PI)) > 1.7 && abs(fmod(gun.rotation, 2*PI)) < 4.5 :
		pass
	else:
		if Input.is_action_just_pressed(prefix+"_fire"):
			var p = projectile.instance()
			p.position = gun.position
			p.velocity = Vector2(10, 0).rotated(gun.rotation + AngleOffset)
			p.rotation = gun.rotation
			p.z_index = 2
			p.scale = Vector2(1,1)
			self.add_child(p)
			p.add_to_group("shots")

	input_vector = input_vector.normalized()
	print(AngleOffset)
	print(fmod(gun.rotation, 2*PI))
	if input_vector != Vector2.ZERO:
		gun.rotation = lerp_angle(gun.rotation, input_vector.angle() - AngleOffset, ROLL_SPEED)


#	if rad2deg(input_vector.angle() - AngleOffset) < -110 || rad2deg(input_vector.angle() - AngleOffset) > 110 || input_vector == Vector2.ZERO:
#		pass
#	elif rad2deg(gun.transform.get_rotation()) >= rad2deg(input_vector.angle() - AngleOffset) - 4 && rad2deg(gun.transform.get_rotation()) <= rad2deg(input_vector.angle() - AngleOffset)+ 4:
#		pass
#	else:
#		###print(rad2deg(engine.transform.get_rotation()))
#		if rad2deg(input_vector.angle() - AngleOffset) > rad2deg(gun.transform.get_rotation()):
#			gun.rotate(.07)
#		elif rad2deg(gun.transform.get_rotation()) > 170 && rad2deg(input_vector.angle() - AngleOffset) < -80:
#			gun.rotate(.07)
#		else:
#			gun.rotate(-.07)
	

func attack_state():
	gun.rotation = lerp_angle(gun.rotation, PI, ROLL_SPEED)
	pass

func crash():
	workable = false
	working = false
	state=ATTACK


func _on_Gunner_area_entered(area):
	workable = true
	if !working:
		prefix = area.name


func _on_Gunner_area_exited(area):
	workable = false
