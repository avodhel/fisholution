extends CanvasLayer

onready var high_score = $MainScreenElements/HighscoreLabel
onready var animation = $AnimationPlayer

var high_score_value

func _ready():
	high_score_value = Global.load_highscore()
	high_score.text = "Highscore: " + str(high_score_value)

func _on_StartButton_pressed():
	animation.play("spin")

func _on_FisholutionStart_pressed():
	Global.which_mode = "fisholution"
	Global.change_scene("GameScene")

func _on_NormalStart_pressed():
	Global.which_mode = "normal"
	Global.change_scene("ChooseScene") # open fish choose screen

func _on_BackButton_pressed():
	animation.play_backwards("spin")
