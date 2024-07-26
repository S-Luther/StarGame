extends "res://Scripts/LancerDrone.gd"


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

const BroadsideDrone = preload('res://Scenes/NPCShips/BroadsideDrone.tscn')
var launchTimer = Timer.new();


# Called when the node enters the scene tree for the first time.
func _ready():
	add_child(launchTimer)
	launchTimer.one_shot = true
	launchTimer.start(5)
	self.radius = 1000
	pass # Replace with function body.

var flipper = 1

func compareAngles(sourceAngle, otherAngle):
	var difference = otherAngle - sourceAngle;

	if (difference < -180.0):
		difference += 360.0;
	if (difference > 180.0):
		difference -= 360.0;

	if (difference > 0.0):
		return 1;
	if (difference < 0.0):
		return -1;

	return flipper;

var opp = 1

# Called every frame. 'delta' is the elapsed time sinsce the previous frame.
func _process(delta):
#	if attacker:
#		print(self.rotation_degrees)
	
	if attacker && launchTimer.is_stopped():
		
		for i in 1:
			var drone = BroadsideDrone.instance()
			rng = RandomNumberGenerator.new()
			rng.randomize()
			var one = fmod(rad2deg(-self.rotation + 2*PI),360)
			var two =  fmod(rad2deg(self.position.angle_to(get_tree().get_nodes_in_group("realPlayer")[0].global_position)+2*PI),360)
			print(one, " ", two, " ", compareAngles(one, two))
			drone.position = self.global_position + Vector2(((randi()%10) * 10) + 100, opp*compareAngles(one, two)*525).rotated(self.rotation)
#			drone.scale = Vector2(.25,.25)
			drone.z_index = 1
			drone.health = .5
			drone.SPEED = 100
			drone.MAX = 2000
			drone.attacker = true

			get_tree().get_nodes_in_group("World")[0].add_child(drone)
			drone.add_to_group("drones")
			drone.add_to_group("NPCs")
			drone.add_to_group("kids")
			flipper = -flipper
		launchTimer.start(3)


func _on_hurt_area_entered(area):
	if attacker:
		for a in area.get_overlapping_bodies():
			if a is Projectile:
				hit(a)
