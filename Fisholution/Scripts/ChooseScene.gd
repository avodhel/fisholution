extends CanvasLayer

export (int) var number_of_fish

onready var show_fish = $ShowFish
onready var animation = $ShowFish/AnimationPlayer
#Score Limit
onready var limit_slider = $ScoreLimit/LimitSlider
onready var score_limit_label = $ScoreLimit/LimitSlider/ScoreLabel

var fish_no
var score_limit_value

func _ready():
	randomize()
	_on_random_pressed()
	score_limit_label.text = str(limit_slider.value)
	score_limit_value = limit_slider.value

func _on_button_pressed():
	Settings.water_click_sound.play()
	for button in get_tree().get_nodes_in_group("button"):
	    button.connect("pressed", self, "_some_button_pressed", [button])

func _some_button_pressed(button):
	match button.name:
		"Fish1_button":
			fish_no = 0
		"Fish2_button":
			fish_no = 1
		"Fish3_button":
			fish_no = 2
		"Fish4_button":
			fish_no = 3
		"Fish5_button":
			fish_no = 4
		"Fish6_button":
			fish_no = 5
		"Fish7_button":
			fish_no = 6
		"Fish8_button":
			fish_no = 7
		"Fish9_button":
			fish_no = 8
		"Fish10_button":
			fish_no = 9
		"Fish11_button":
			fish_no = 10
		"Fish12_button":
			fish_no = 11
		"Fish13_button":
			fish_no = 12
	
	if fish_no != null:
		_show_fish(fish_no)
	else:
		return

func _show_fish(fish_no):
	var frame_y = fish_no * 32
	show_fish.region_rect.position.y = frame_y
	animation.play("idle")

func _on_random_pressed():
	Settings.water_click_sound.play()
	fish_no = randi() % number_of_fish  # returns random integer between 0 and (number_of_fish - 1)
	_show_fish(fish_no)

func _on_start_pressed():
	Settings.water_click_sound.play()
	Global.change_scene("GameScene") # start game
	Global.fish_no = fish_no
	Global.score_limit = score_limit_value
	print(Global.score_limit)

func _on_LimitSlider_value_changed(value):
	score_limit_value = value
	score_limit_label.text = str(score_limit_value)
	Global.score_limit = score_limit_value
