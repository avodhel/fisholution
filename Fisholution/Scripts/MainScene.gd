extends CanvasLayer

onready var high_score = $HighscoreLabel

var high_score_value

func _ready():
	high_score_value = Global.load_highscore()
	high_score.text = "Highscore: " + str(high_score_value)

func _on_StartButton_pressed():
	Global.change_scene("ChooseScene") # open fish choose screen
