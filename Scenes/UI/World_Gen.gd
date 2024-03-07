extends Control


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var avatar = $Node2D2/avatar
onready var stats = $Node2D2/ScrollContainer2/Label
onready var logs = $Node2D2/ScrollContainer/Label2
onready var backup = $Node2D2/ScrollContainer/Label3
onready var randB = $Node2D2/Button

var factionLength = 0;
var previousFactions = []
var galaxy;
var logsBack = ""
#onready var randBu = $Button2
var OnePlayerWorld = preload("res://Scenes/Shuttle/1pWorld.tscn").instance()

# Called when the node enters the scene tree for the first time.
func _ready():
	self.add_to_group("OverView")
	avatar.frame = randi() % 48

func difference(arr1, arr2):
	var only_in_arr1 = []
	for v in arr1:
		if not (v in arr2):
			only_in_arr1.append(v)
	return only_in_arr1


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mousePos = get_global_mouse_position()
	
	
		
	
#	print(mousePos)
	var Galaxy = get_tree().get_nodes_in_group("Galaxy")
	
	
	var nodes = []
	
	
	
	for g in Galaxy:
		nodes = g.nodes
		logs.text = g.logs
		galaxy = g;
		
#		var split = g.logs.split("\n")
#		if split.size() > 12:
#			logsBack = ""
#			logsBack = g.logs
#			backup.text = logsBack
#			g.logs = ""
	
	var text = "";
	var totalPop = 0
	var unique_factions = []
	for n in nodes:
		totalPop = totalPop + n.residents.size()
		if !unique_factions.has(n.faction):
			unique_factions.append(n.faction)
	
	text = "Total Pop: " + String(totalPop) + "\nNumber of Worlds: " + String(nodes.size()) + "\n\n"
	
	for f in unique_factions:
		text = text + f + "\n"
	

	for l in get_tree().get_nodes_in_group("labels"):
		l.visible = false
	
	if mousePos.x > 2200:
		var mouseY = mousePos.y - 400
		var faction = int(mouseY / 50)
		
#		print(mouseY / 50)

		if faction < (unique_factions.size()+1) && faction > 0:
			for n in nodes:
				if n.faction == unique_factions[faction-1]:
					for l in get_tree().get_nodes_in_group("labels"):
						if n.name.is_subsequence_of(l.text):
#							print(faction)
							l.visible = true
						
						
	else:
		for p in range(nodes.size()):
			if mousePos.distance_to(nodes[p].pos) < 50:
				get_tree().get_nodes_in_group("labels")[p].visible = true
			else:
				get_tree().get_nodes_in_group("labels")[p].visible = false
		
	if !(unique_factions.size() > 0):
		avatar.frame = randi() % 48
		
		
	stats.text = text
	stats.rect_scale = Vector2(3,3);
	



func _on_Button_pressed():
	randomize()
	avatar.frame = randi() % 48


func _on_Button2_pressed():
	galaxy.rebuild()


func _on_Button3_pressed():
	get_tree().get_root().add_child(OnePlayerWorld)
	self.visible = false
