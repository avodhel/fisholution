extends CanvasLayer

signal restart_game # emit when we push the start button
signal fisholution_up

onready var score_label = $ScoreLabel
onready var fisholution_bar = $FisholutionBar
onready var title_label = $TitleLabel
onready var highscore_label = $HighscoreLabel
onready var restart_button = $RestartButton
onready var message_timer = $MessageTimer
onready var blur = $Blur

var highscore_value
var xp = 10

func _ready():
	highscore_value = str(PlayerData.load_highscore())
	highscore_label.text = "Highscore: " + highscore_value

func show_message(text):
	title_label.text = text
	title_label.show()
	message_timer.start()

func game_over():
	#show all restart ui
	blur.visible = true
	score_label.visible = true
	fisholution_bar.visible = true
	title_label.visible = true
	highscore_label.visible = true
	restart_button.visible = true
	
	show_message("Fisholution \nOver")
	yield(message_timer, "timeout") # show message until timeout signal appears (wait time)
	restart_button.show()
	title_label.text = "Fisholution"
	title_label.show()
	highscore_value = str(PlayerData.load_highscore()) # update high score
	highscore_label.text = "Highscore: " + highscore_value # assign high score to text
	highscore_label.show() # show high score
	blur.show()

func update_score(score):
	score_label.text = str(score)

func _on_MessageTimer_timeout():
	title_label.hide()

func _on_RestartButton_pressed():
	highscore_label.hide()
	restart_button.hide()
	emit_signal("restart_game")
	fisholution_bar.show()
	blur.hide()

func _on_Fish_xp_gained():
	var increase_xp = fisholution_bar.max_value / (fisholution_bar.level * xp) #reduce xp amount after every fisholution
	fisholution_bar.fisholution_process(increase_xp)

func _on_FisholutionBar_fisholution_up():
	emit_signal("fisholution_up")
