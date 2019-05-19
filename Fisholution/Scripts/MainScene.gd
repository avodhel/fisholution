extends CanvasLayer

onready var mainscreen_elements = $MainScreenElements
onready var modes = $Modes
onready var high_score = $MainScreenElements/HighscoreLabel

var high_score_value

func _ready():
	high_score_value = Global.load_highscore()
	high_score.text = "Highscore: " + str(high_score_value)

func _on_StartButton_pressed():
	mainscreen_elements.hide()
	modes.show()

func _on_FisholutionStart_pressed():
	pass # Replace with function body.

func _on_NormalStart_pressed():
	Global.change_scene("ChooseScene") # open fish choose screen
