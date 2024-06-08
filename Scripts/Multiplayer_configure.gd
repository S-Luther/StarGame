extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var OnePB = $"1Player2"
onready var ThreePB = $"3Player"
onready var Background = $Sprite
var TwoPlayerWorld = preload("res://Scenes/ExpeditionaryVessel/2pWorld.tscn")
var OnePlayerWorld = preload("res://Scenes/Shuttle/1pWorld.tscn")
var ThreePlayerWorld = preload("res://Scenes/Platform/World.tscn")
var Map = preload("res://Scenes/UI/World_Gen.tscn")
var FacsWorld = preload("res://Scenes/GunShip/GunShip.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_2Player_pressed():
	get_tree().get_root().add_child(TwoPlayerWorld.instance())
	OnePB.visible = false
	ThreePB.visible = false
	Background.visible = false

func _on_1Player2_pressed():
	get_tree().get_root().add_child(OnePlayerWorld.instance())
	OnePB.visible = false
	ThreePB.visible = false
	Background.visible = false

func _on_3Player_pressed():
	get_tree().get_root().add_child(ThreePlayerWorld.instance())
	ThreePB.visible = false
	OnePB.visible = false
	Background.visible = false


func _on_Extra_pressed():
	get_tree().get_root().add_child(FacsWorld.instance())
	ThreePB.visible = false
	OnePB.visible = false
	Background.visible = false


func _on_Map_pressed():
	get_tree().get_root().add_child(Map.instance())
	ThreePB.visible = false
	OnePB.visible = false
	Background.visible = false
