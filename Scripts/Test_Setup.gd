extends Control

onready var Key_Display = $Key_Code2
onready var Player2 = $Player_2
onready var Player2B = $Player2Add
onready var Player3 = $Player_3
onready var Player3B = $Player3Add
onready var Player4 = $Player_4
onready var Player4B = $Player4Add
onready var back = $rif
onready var a = $A
onready var ah = $AH
onready var c = $C
onready var ds = $DS
onready var d = $D
onready var e = $E
onready var g = $G
onready var Test_Setup = self
var config = ConfigFile.new()
var mode = ""
var current_ev = 0

var beatTimer = Timer.new()

var riffTimer = Timer.new()

var ev = InputEventKey.new()

var setup = true



func _ready():
#	back.stream.loop_offset = 1.44
	back.play()
	add_child(beatTimer)
	beatTimer.one_shot = true
	
	beatTimer.start(4.5)
	
	add_child(riffTimer)
	riffTimer.one_shot = true
	
	
	
	riffTimer.start(4.5)
	
	var configl = ConfigFile.new()

	var err = configl.load("user://inputs.cfg")
	
	if err != OK:
		return
	
	for input in configl.get_sections():
		InputMap.add_action(configl.get_value(input, "action")) 
		ev = configl.get_value(input, "ev")
		InputMap.action_add_event(configl.get_value(input, "action"), ev)

func saveInputs(theaction, theev):
	config.set_value(theaction, "action", theaction)
	config.set_value(theaction, "ev", theev)
	config.save("user://inputs.cfg")
	

func _unhandled_key_input(event):
	if event is InputEventJoypadMotion:
		print(event)
	if event.is_pressed() && setup:
		current_ev = event

		Key_Display.text = String(event.scancode)
func _unhandled_input(event):
	if event is InputEventJoypadMotion:
		print(event)
	if event.is_pressed() && setup:
		#print(event.get_instance_id())
		current_ev = event
		Key_Display.text = String(event.get_instance_id())


func _on_Right_pressed():

	ev = current_ev

	if InputMap.has_action("p1_right"):
		InputMap.erase_action("p1_right")
	InputMap.add_action("p1_right")
	InputMap.action_add_event("p1_right", ev)
	saveInputs("p1_right", ev)


func _on_Down_pressed():

	ev = current_ev

	if InputMap.has_action("p1_down"):
		InputMap.erase_action("p1_down")
	InputMap.add_action("p1_down")
	InputMap.action_add_event("p1_down", ev)
	saveInputs("p1_down", ev)


func _on_Up_pressed():

	ev = current_ev
	if InputMap.has_action("p1_up"):
		InputMap.erase_action("p1_up")

	InputMap.add_action("p1_up")
	InputMap.action_add_event("p1_up", ev)
	saveInputs("p1_up", ev)

func _on_Left_pressed():

	ev = current_ev
#	print(ev)

	if InputMap.has_action("p1_left"):
		InputMap.erase_action("p1_left")
	InputMap.add_action("p1_left")
	InputMap.action_add_event("p1_left", current_ev)
	saveInputs("p1_left", current_ev)

func _on_Primary_pressed():

	ev = current_ev
#	print(ev)
	if InputMap.has_action("p1_swing"):
		InputMap.erase_action("p1_swing")
	InputMap.add_action("p1_swing")
	InputMap.action_add_event("p1_swing", current_ev)
	saveInputs("p1_swing", current_ev)

func _on_Seconday_pressed():

	ev = current_ev
#	print(ev)
	if InputMap.has_action("p1_fire"):
		InputMap.erase_action("p1_fire")
	InputMap.add_action("p1_fire")
	InputMap.action_add_event("p1_fire", current_ev)
	saveInputs("p1_fire", current_ev)


func _on_Player2Add_pressed():
	Player2.visible = true
	Player2B.visible = false


func _on_Player3Add_pressed():
	Player3.visible = true
	Player3B.visible = false


func _on_Player4Add_pressed():
	Player4.visible = true
	Player4B.visible = false

func _on_Map_pressed():
	Test_Setup.visible =false
	setup = false

func _on_p2Right_pressed():

	ev = current_ev
	if InputMap.has_action("p2_right"):
		InputMap.erase_action("p2_right")
	InputMap.add_action("p2_right")
	InputMap.action_add_event("p2_right", ev)
	saveInputs("p2_right", ev)

func _on_p2Down_pressed():

	ev = current_ev
	if InputMap.has_action("p2_down"):
		InputMap.erase_action("p2_down")
	InputMap.add_action("p2_down")
	InputMap.action_add_event("p2_down", ev)
	saveInputs("p2_down", ev)

func _on_p2Up_pressed():

	ev = current_ev
	
	if InputMap.has_action("p2_up"):
		InputMap.erase_action("p2_up")
	InputMap.add_action("p2_up")
	InputMap.action_add_event("p2_up", ev)
	saveInputs("p2_up", ev)

func _on_p2Left_pressed():

	ev = current_ev
	
	if InputMap.has_action("p2_left"):
		InputMap.erase_action("p2_left")
	InputMap.add_action("p2_left")
	InputMap.action_add_event("p2_left", ev)
	saveInputs("p2_left", ev)

func _on_p2Primary_pressed():

	ev = current_ev

	if InputMap.has_action("p2_swing"):
		InputMap.erase_action("p2_swing")
	InputMap.add_action("p2_swing")
	InputMap.action_add_event("p2_swing", ev)
	saveInputs("p2_swing", ev)

func _on_p2Secondary_pressed():

	ev = current_ev
#	print(ev)
	if InputMap.has_action("p2_fire"):
		InputMap.erase_action("p2_fire")
	InputMap.add_action("p2_fire")
	InputMap.action_add_event("p2_fire", current_ev)
	saveInputs("p2_fire", current_ev)
	pass # Replace with function body.


func _on_p3Right_pressed():

	ev = current_ev
	
	if InputMap.has_action("p3_right"):
		InputMap.erase_action("p3_right")
	InputMap.add_action("p3_right")
	InputMap.action_add_event("p3_right", ev)
	saveInputs("p3_right", ev)

func _on_p3Down_pressed():

	ev = current_ev
	if InputMap.has_action("p3_down"):
		InputMap.erase_action("p3_down")
	InputMap.add_action("p3_down")
	InputMap.action_add_event("p3_down", ev)
	saveInputs("p3_down", ev)

func _on_p3Up_pressed():

	ev = current_ev
	
	if InputMap.has_action("p3_up"):
		InputMap.erase_action("p3_up")
	InputMap.add_action("p3_up")
	InputMap.action_add_event("p3_up", ev)
	saveInputs("p3_up", ev)

func _on_p3Left_pressed():

	ev = current_ev
	
	if InputMap.has_action("p3_left"):
		InputMap.erase_action("p3_left")
	InputMap.add_action("p3_left")
	InputMap.action_add_event("p3_left", ev)
	saveInputs("p3_left", ev)

func _on_p3Primary_pressed():

	ev = current_ev

	if InputMap.has_action("p3_swing"):
		InputMap.erase_action("p3_swing")
	InputMap.add_action("p3_swing")
	InputMap.action_add_event("p3_swing", ev)
	saveInputs("p3_swing", ev)

func _on_p3Secondary_pressed():
	pass # Replace with function body.


func _on_p4Right_pressed():

	ev = current_ev
	
	if InputMap.has_action("p4_right"):
		InputMap.erase_action("p4_right")
	InputMap.add_action("p4_right")
	InputMap.action_add_event("p4_right", ev)
	saveInputs("p4_right", ev)

func _on_p4Down_pressed():

	ev = current_ev
	if InputMap.has_action("p4_down"):
		InputMap.erase_action("p4_down")
	InputMap.add_action("p4_down")
	InputMap.action_add_event("p4_down", ev)
	saveInputs("p4_down", ev)

func _on_p4Up_pressed():

	ev = current_ev
	
	if InputMap.has_action("p4_up"):
		InputMap.erase_action("p4_up")
	InputMap.add_action("p4_up")
	InputMap.action_add_event("p4_up", ev)
	saveInputs("p4_up", ev)

func _on_p4Left_pressed():

	ev = current_ev
	
	if InputMap.has_action("p4_left"):
		InputMap.erase_action("p4_left")
	InputMap.add_action("p4_left")
	InputMap.action_add_event("p4_left", ev)
	saveInputs("p4_left", ev)

func _on_p4Primary_pressed():

	ev = current_ev
	if InputMap.has_action("p4_swing"):
		InputMap.erase_action("p4_swing")
	InputMap.add_action("p4_swing")
	InputMap.action_add_event("p4_swing", ev)
	saveInputs("p4_swing", ev)


func _on_p4Secondary_pressed():
	pass # Replace with function body.


func _on_1Player2_pressed():
	Test_Setup.visible =false
	setup = false

func _on_3Player_pressed():
	Test_Setup.visible =false
	setup = false

func _on_Extra_pressed():
	Test_Setup.visible =false
	setup = false


func _on_2Player_pressed():
	Test_Setup.visible =false
	setup = false






func _physics_process(delta):
#	a.stream.loop_offset = 0.02

	if (randi() % 5000) == 0:
		var pause = randi() % 2
		riffTimer.stop()
		riffTimer.start(pause*2.25)
		beatTimer.stop()
		beatTimer.start(pause*2.25)


	if riffTimer.is_stopped():
		back.stop()
		back.play()
		riffTimer.start(2.25)
	 
	if beatTimer.is_stopped():
		
		
		randomize()
		var note = randi()%12
		
		
		if note == 0:
			a.stop()
			ah.stop()
			c.stop()
			ds.stop()
			d.stop()
			e.stop()
			g.stop()
		elif note == 1:
			a.stop()
			ah.stop()
			c.stop()
			ds.stop()
			d.stop()
			e.stop()
			g.stop()
			a.play()
		elif note == 2:
			a.stop()
			ah.stop()
			c.stop()
			ds.stop()
			d.stop()
			e.stop()
			g.stop()
			ah.play()
		elif note == 3:
			a.stop()
			ah.stop()
			c.stop()
			ds.stop()
			d.stop()
			e.stop()
			g.stop()
			c.play()
		elif note == 4:
			a.stop()
			ah.stop()
			c.stop()
			ds.stop()
			d.stop()
			e.stop()
			g.stop()
			ds.play()
			pass
		elif note == 5:
			a.stop()
			ah.stop()
			c.stop()
			ds.stop()
			d.stop()
			e.stop()
			g.stop()
			d.play()
		elif note == 6:
			a.stop()
			ah.stop()
			c.stop()
			ds.stop()
			d.stop()
			e.stop()
			g.stop()
			e.play()
		elif note == 7:
			a.stop()
			ah.stop()
			c.stop()
			ds.stop()
			d.stop()
			e.stop()
			g.stop()
			g.play()
		elif note > 7:
			pass
			
		beatTimer.start(.1875)

