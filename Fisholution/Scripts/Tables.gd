extends Node2D

signal eliminate_fish(whichfish)

onready var table_title = $TableTitle

var fishtable_elements = []
var fishtable_labels = []
var scoretable_elements = []
var scoretable_labels = []
var fish_no = null

func _ready():
	if self.name == "FishTable":
		fishtable_elements = $FishTable_elements.get_children()
	if self.name == "ScoreTable":
		scoretable_elements = $ScoreTable_elements.get_children()
	reset_table()
	table_transparency(false)

func increase_or_reduce(whichfish, situation, whichtable):
	if whichfish.is_in_group("fish1"):
		fish_no = 0
	elif whichfish.is_in_group("fish2"):
		fish_no = 1
	elif whichfish.is_in_group("fish3"):
		fish_no = 2
	elif whichfish.is_in_group("fish4"):
		fish_no = 3
	elif whichfish.is_in_group("fish5"):
		fish_no = 4
	elif whichfish.is_in_group("fish6"):
		fish_no = 5
	elif whichfish.is_in_group("fish7"):
		fish_no = 6
	elif whichfish.is_in_group("fish8"):
		fish_no = 7
	elif whichfish.is_in_group("fish9"):
		fish_no = 8
	elif whichfish.is_in_group("fish10"):
		fish_no = 9
	elif whichfish.is_in_group("fish11"):
		fish_no = 10
	elif whichfish.is_in_group("fish12"):
		fish_no = 11
	elif whichfish.is_in_group("fish13"):
		fish_no = 12
	
	if whichtable == "fishtable" and fish_no != null:
		match situation:
			"inc":
				_inc_nof(fish_no)
				fish_no = null
			"red":
				_red_nof(fish_no)
				fish_no = null
	elif whichtable == "scoretable" and fish_no != null:
		match situation:
			"inc":
				_inc_sof(fish_no)
				fish_no = null
	else:
		return

func _inc_nof(fish_no): # increase number of fish
	fishtable_elements[fish_no].value += 1
	fishtable_labels[fish_no].text = str(fishtable_elements[fish_no].value)

func _red_nof(fish_no): #reduce number of fish
	fishtable_elements[fish_no].value -= 1
	fishtable_labels[fish_no].text = str(fishtable_elements[fish_no].value)

	if fishtable_elements[fish_no].value == 0:
		emit_signal("eliminate_fish", fish_no)
		_eliminate_from_table(fish_no)
		print(fishtable_elements.size(), scoretable_elements.size())

func _inc_sof(fish_no): #increase score of fish
	scoretable_elements[fish_no].value += 1
	scoretable_labels[fish_no].text = str(scoretable_elements[fish_no].value)

	if scoretable_elements[fish_no].value == scoretable_elements[fish_no].max_value:
		print(str(fish_no) + " won the game")
		get_tree().paused = true #pause game

func reset_table(): # reset tables
	for i in fishtable_elements.size():
		fishtable_elements[i].value = 0
		var fishtable_label = fishtable_elements[i].get_child(0)
		fishtable_labels.append(fishtable_label)
		fishtable_label.text = str(fishtable_elements[i].value)

	for i in scoretable_elements.size():
		scoretable_elements[i].value = 0
		var scoretable_label = scoretable_elements[i].get_child(0)
		scoretable_labels.append(scoretable_label)
		scoretable_label.text = str(scoretable_elements[i].value)

func table_transparency(on):
	for i in fishtable_elements.size():
		if on:
			fishtable_elements[i].modulate.a = 0.5
			self.position.x = 390 #hide fishes
		else:
			fishtable_elements[i].modulate.a = 1
			self.position.x = 360 #show fishes

		fishtable_elements[Global.fish_no].get_child(2).visible = true # visible remarkable sign

	for i in scoretable_elements.size():
		if on:
			scoretable_elements[i].modulate.a = 0.5
			self.position.x = -30 #hide fishes
		else:
			scoretable_elements[i].modulate.a = 1
			self.position.x = 0 #show fishes

		scoretable_elements[Global.fish_no].get_child(2).visible = true # visible remarkable sign
	
	if on:
		table_title.visible = false
	else:
		table_title.visible = true

func _eliminate_from_table(fish_no):
	fishtable_elements[fish_no].get_child(1).visible = true #visible eliminate sign


