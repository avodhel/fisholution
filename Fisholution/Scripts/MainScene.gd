extends CanvasLayer

onready var high_score = $MainScreenElements/HighscoreLabel
onready var animation = $AnimationPlayer
#onready var game_music = $GameMusic
onready var music_slider = $Settings/Music/MusicSlider
onready var sounds_slider = $Settings/Sounds/SoundsSlider

var high_score_value

func _ready():
	high_score_value = Global.load_highscore()
	high_score.text = "Highscore: " + str(high_score_value)
	music_slider.set_value(Settings.music_volume)
	sounds_slider.set_value(Settings.sounds_volume)
	yield(get_tree().create_timer(1),"timeout")
	Settings.game_music.play()

#MAIN SCENE
func _on_StartButton_pressed():
	Settings.water_click_sound.play()
	animation.play("spin_left")

func _on_SettingsButton_pressed():
	Settings.water_click_sound.play()
	animation.play("spin_right")

#MODES SCENE
func _on_FisholutionStart_pressed():
	Settings.water_click_sound.play()
	Global.which_mode = "fisholution"
	Global.change_scene("GameScene")
	Settings.game_music.stop()

func _on_NSStart_pressed():
	Settings.water_click_sound.play()
	Global.which_mode = "natural_selection"
	Global.change_scene("ChooseScene") # open fish choose screen
	Settings.game_music.stop()

func _on_SpinLeftButton_pressed():
	Settings.water_click_sound.play()
	animation.play_backwards("spin_left")

#SETTINGS SCENE
func _on_SpinRightButton_pressed():
	Settings.water_click_sound.play()
	animation.play_backwards("spin_right")

func _on_MusicSlider_value_changed(value):
	Settings.music_volume = value
	Settings.save_settings()

func _on_SoundsSlider_value_changed(value):
	Settings.sounds_volume = value
	Settings.save_settings()
#	print("value: " + str(value))
