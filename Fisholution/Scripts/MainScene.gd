extends CanvasLayer

onready var high_score = $MainScreenElements/HighscoreLabel
onready var animation = $AnimationPlayer
onready var gamemusic = $GameMusic

var high_score_value

func _ready():
	high_score_value = Global.load_highscore()
	high_score.text = "Highscore: " + str(high_score_value)
	gamemusic.play()

#MAIN SCENE
func _on_StartButton_pressed():
	animation.play("spin_left")

func _on_SettingsButton_pressed():
	animation.play("spin_right")

#MODES SCENE
func _on_FisholutionStart_pressed():
	Global.which_mode = "fisholution"
	Global.change_scene("GameScene")

func _on_NSStart_pressed():
	Global.which_mode = "natural_selection"
	Global.change_scene("ChooseScene") # open fish choose screen

func _on_SpinLeftButton_pressed():
	animation.play_backwards("spin_left")

#SETTINGS SCENE
func _on_SpinRightButton_pressed():
	animation.play_backwards("spin_right")
