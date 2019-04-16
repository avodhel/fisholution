extends CanvasLayer

signal start_game # emit when we push the start button
signal fisholution_up

onready var score_label = $ScoreLabel
onready var fisholution_bar = $FisholutionBar
onready var title_label = $TitleLabel
onready var start_button = $StartButton
onready var message_timer = $MessageTimer

func show_message(text):
	title_label.text = text
	title_label.show()
	message_timer.start()

func game_over():
	show_message("Fisholution Over")
	yield(message_timer, "timeout") # show message until timeout signal appears (wait time)
	start_button.show()
	title_label.text = "Fisholution"
	title_label.show()

func update_score(score):
	score_label.text = str(score)

func _on_MessageTimer_timeout():
	title_label.hide()

func _on_StartButton_pressed():
	start_button.hide()
	emit_signal("start_game")
	fisholution_bar.show()

func _on_Fish_xp_gained():
	fisholution_bar.fisholution_process(10)

func _on_FisholutionBar_fisholution_up():
	emit_signal("fisholution_up")
