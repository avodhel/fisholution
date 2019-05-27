extends CanvasLayer

signal fisholution_up

onready var blur = $Blur
#fisholution completed panel
onready var fisholution_completed_panel = $FisholutionCompletedPanel
onready var keep_playing_button = $FisholutionCompletedPanel/Panel/KeepPlayingButton
#ns completed panel
onready var ns_completed_panel = $NSCompletedPanel
onready var winner_fish_label = $NSCompletedPanel/Panel/WinnerFishLabel
onready var winner_fish_sprite1 = $NSCompletedPanel/Panel/WonLabel/WinnerFish1
onready var winner_fish_sprite2 = $NSCompletedPanel/Panel/WonLabel/WinnerFish2
#fisholution bar
onready var fisholution_bar = $FisholutionBar
#Labels
onready var score_label = $Labels/ScoreLabel
onready var title_label = $Labels/TitleLabel
onready var highscore_label = $Labels/HighscoreLabel
#Buttons
onready var restart_button = $Buttons/RestartButton
onready var choosescene_button = $Buttons/ChooseSceneButton
onready var home_button = $Buttons/HomeButton
onready var pause_button = $Buttons/PauseButton
onready var resume_button = $Buttons/ResumeButton
onready var message_timer = $MessageTimer

var highscore_value
var xp = 5

func _ready():
	_assign_highscore()
	_prepare_hud_scene("ready")

func show_message(text, hide_or_not):
	title_label.text = text
	title_label.show()
	if hide_or_not == true:
		message_timer.start()

func game_over():
	_prepare_hud_scene("game_over")

func _assign_highscore():
	highscore_value = str(Global.load_highscore()) # update high score
	highscore_label.text = "Highscore: " + highscore_value # assign high score to text

func update_score(score):
	score_label.text = str(score)

func _on_MessageTimer_timeout():
	title_label.hide()

func _on_RestartButton_pressed():
	_prepare_hud_scene("restart")

func _on_ChooseSceneButton_pressed():
	Global.change_scene("ChooseScene")

func _on_HomeButton_pressed():
	Global.change_scene("MainScene")

func _on_PauseButton_pressed():
	_prepare_hud_scene("pause")

func _on_ResumeButton_pressed():
	_prepare_hud_scene("resume")

func _on_Fish_xp_gained():
	var increase_xp = fisholution_bar.max_value / (fisholution_bar.level * xp) #reduce xp amount after every fisholution
	fisholution_bar.fisholution_process(increase_xp)

func _on_FisholutionBar_fisholution_up():
	emit_signal("fisholution_up")

func _show_fisholution_completed_panel():
	_prepare_hud_scene("fisholution_completed")

func _show_ns_completed_panel(who_win):
	print(who_win)
	_prepare_hud_scene("ns_completed")

func _keep_playing():
	_prepare_hud_scene("keep_playing")

func _prepare_hud_scene(condition):
	match condition:
		"ready":
			if Global.which_mode == "fisholution":
				fisholution_bar.connect("show_congrats_panel", self, "_show_fisholution_completed_panel")
				keep_playing_button.connect("pressed", self, "_keep_playing")
			elif Global.which_mode == "natural_selection":
				score_label.rect_position = Vector2(140, 0)
				$Tables.get_node("ScoreTable").connect("ns_completed", self, "_show_ns_completed_panel")
		"restart":
			blur.hide()
			fisholution_completed_panel.hide()
			fisholution_bar.show()
			highscore_label.hide()
			restart_button.hide()
			home_button.hide()
			choosescene_button.hide()
			Global.change_scene("GameScene") # reload game scene
		"game_over":
			if Global.which_mode == "fisholution":
				fisholution_bar.show()
			elif Global.which_mode == "natural_selection":
				choosescene_button.show()
				home_button.rect_position = Vector2(200, 560)
			blur.show()
			score_label.show()
			home_button.rect_position = Vector2(260, 460)
			home_button.show()
			show_message("Game Over", false)
			_assign_highscore()
			highscore_label.show()
			restart_button.show()
			pause_button.hide()
		"fisholution_completed":
			get_tree().paused = true
			blur.show()
			fisholution_completed_panel.show()
			highscore_label.show()
			home_button.show()
			home_button.rect_position = Vector2(200, 460)
			pause_button.hide()
		"keep_playing":
			blur.hide()
			fisholution_completed_panel.hide()
			highscore_label.hide()
			restart_button.hide()
			home_button.hide()
			pause_button.show()
			show_message("Game Continues", false)
			yield(get_tree().create_timer(3), "timeout")
			title_label.hide()
			get_tree().paused = false
		"ns_completed":
			pass
		"pause":
			pause_button.hide()
			resume_button.show()
			get_tree().paused = true
			blur.show()
			show_message("Paused", false)
			highscore_label.show()
			if Global.which_mode == "fisholution":
				home_button.rect_position = Vector2(200, 460)
				home_button.show()
			elif Global.which_mode == "natural_selection":
				choosescene_button.show()
				home_button.rect_position = Vector2(140, 460)
				home_button.show()
				$Tables.get_node("FishTable").table_transparency(false)
				$Tables.get_node("ScoreTable").table_transparency(false)
		"resume":
			resume_button.hide()
			pause_button.show()
			get_tree().paused = false
			blur.hide()
			title_label.hide()
			highscore_label.hide()
			if Global.which_mode == "fisholution":
				home_button.hide()
			elif Global.which_mode == "natural_selection":
				choosescene_button.hide()
				home_button.hide()
				$Tables.get_node("FishTable").table_transparency(true)
				$Tables.get_node("ScoreTable").table_transparency(true)

