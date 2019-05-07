extends Node2D

var fishtable_elements = []
var fishtable_labels = []
var fish_no = null

func _ready():
	reset_table()

func increase_or_reduce(whichfish, situation):
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
	
	if fish_no != null:
		match situation:
			"inc":
				_inc_nof(fish_no)
				fish_no = null
			"red":
				_red_nof(fish_no)
				fish_no = null
	else:
		return

func _inc_nof(fish_no): # increase number of fish
	fishtable_elements[fish_no].value += 1
	fishtable_labels[fish_no].text = str(fishtable_elements[fish_no].value)
	
func _red_nof(fish_no): #reduce number of fish
	fishtable_elements[fish_no].value -= 1
	fishtable_labels[fish_no].text = str(fishtable_elements[fish_no].value)

func reset_table(): # reset fish table
	fishtable_elements = self.get_children()
	for i in fishtable_elements.size():
		fishtable_elements[i].value = 0
		var fishtable_label = fishtable_elements[i].get_child(0)
		fishtable_labels.append(fishtable_label)
		fishtable_label.text = str(fishtable_elements[i].value)