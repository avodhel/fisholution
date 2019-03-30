extends CanvasLayer

signal start_game # emit when we push the start button

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()

func game_over():
	show_message("Game Over")
	yield($MessageTimer, "timeout") # show message until timeout signal appears (wait time)
	$StartButton.show()
	$MessageLabel.text = "Fisholution"
	$MessageLabel.show()

func update_score(score):
	$ScoreLabel.text = str(score)

func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_StartButton_pressed():
	$StartButton.hide()
	emit_signal("start_game")
	$FisholutionBar.show()

func _on_Fish_xp_gained():
	$FisholutionBar.fisholution_process(10)
