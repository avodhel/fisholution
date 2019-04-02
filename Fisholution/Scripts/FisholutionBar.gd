extends ProgressBar

signal fisholution_up # when fisholution level increase

var level = 1
#var required_xp
#var increase_xp = 1

func _ready():
	$Bubble/FisholutionLevelLabel.text = str(level)

func fisholution_process(increase_xp):
	if value < max_value:
		value += increase_xp
	else:
		fisholution_level_up(level + 1)

func fisholution_level_up(level_up):
	$Bubble/FisholutionLevelLabel.text = str(level_up)
	level = level_up
	value = 0
	max_value += max_value / 2
	print(max_value)
	emit_signal("fisholution_up")
	
func reset_fisholution():
	value = 0
	max_value = 100
	level = 1
	$Bubble/FisholutionLevelLabel.text = str(level)