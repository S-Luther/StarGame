extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var t = Timer.new()

var strength: float = 30.0
var fade: float = 5.0

var rng = RandomNumberGenerator.new()



var shake_strength: float = 0.0

func apply_shake():
	t.start(.5)
	shake_strength = strength
	



# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_child(t)
	t.one_shot = true
	self.add_to_group("cam")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if shake_strength > 0.0:
		shake_strength = lerp(shake_strength, 0.0, fade * delta)
		offset = randomOffset()
	
	if t.is_stopped():
		shake_strength = 0.0
		
func randomOffset() -> Vector2:
	return Vector2(rng.randf_range(-strength,strength),rng.randf_range(-strength,strength))
	
