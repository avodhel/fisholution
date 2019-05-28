extends ProgressBar

signal fisholution_up # when fisholution level increase
signal show_congrats_panel # when fisholution completed show congrats panel

onready var fisholution_level_label = $FisholutionLevelLabel

var level = 1
var border_of_level = 5

func _ready():
	fisholution_level_label.text = str(level)

func fisholution_process(increase_xp):
#	print(increase_xp)
	if level != border_of_level:
		if value < max_value:
			value += increase_xp
		else:
			fisholution_level_up(level + 1)

func fisholution_level_up(level_up):
	if level_up == border_of_level:
		fisholution_level_label.text = str(level_up)
		level = level_up
		value = 0
		max_value += max_value / 2
		emit_signal("show_congrats_panel")
	else:
		fisholution_level_label.text = str(level_up)
		level = level_up
		value = 0
		max_value += max_value / 2
		emit_signal("fisholution_up")
	
func reset_fisholution():
	value = 0
	max_value = 100
	level = 1
	fisholution_level_label.text = str(level)