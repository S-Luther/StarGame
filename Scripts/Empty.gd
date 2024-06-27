extends Area2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var anim = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	print(area.get_overlapping_bodies())
	var p = area.get_overlapping_bodies()
	for a in area.get_overlapping_bodies():
		if !a.NPC:
			anim.play("blinkin")
			print("Entered into a spot")
	pass # Replace with function body.
