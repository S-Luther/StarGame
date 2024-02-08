extends Area2D



enum {
	MOVE,
	ROLL,
	ATTACK,
	HIT
}


var i = 0

var state = ATTACK


var workable = false
var working = false

onready var gun = $GunUp

var prefix = ""


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
		
	
func move_state():
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength(prefix+"_left") - Input.get_action_strength(prefix+"_right")
	input_vector.y = Input.get_action_strength(prefix+"_up") - Input.get_action_strength(prefix+"_down")

	input_vector = input_vector.normalized()

	if rad2deg(input_vector.angle()) < -30 || rad2deg(input_vector.angle()) > 270 || input_vector == Vector2.ZERO:
		pass
	elif rad2deg(gun.transform.get_rotation()) >= rad2deg(input_vector.angle()) - 4 && rad2deg(gun.transform.get_rotation()) <= rad2deg(input_vector.angle())+ 4:
		pass
	else:
		###print(rad2deg(engine.transform.get_rotation()))
		if rad2deg(input_vector.angle()) > rad2deg(gun.transform.get_rotation()):
			gun.rotate(.07)
		elif rad2deg(gun.transform.get_rotation()) > 170 && rad2deg(input_vector.angle()) < -80:
			gun.rotate(.07)
		else:
			gun.rotate(-.07)
	

func attack_state():
	pass

func crash():
	workable = false
	working = false
	state=ATTACK

func _on_GunUpTerm_area_exited(area):
	workable = false


func _on_GunUpTerm_area_entered(area):
	workable = true
	if !working:
		prefix = area.name
