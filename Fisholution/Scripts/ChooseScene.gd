extends CanvasLayer

export (int) var number_of_fish

onready var show_fish = $ShowFish
onready var animation = $ShowFish/AnimationPlayer

var fish_no

func _ready():
	randomize()
	_on_random_pressed()

func _on_button_pressed():
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
	fish_no = randi() % number_of_fish  # returns random integer between 0 and (number_of_fish - 1)
	_show_fish(fish_no)

func _on_start_pressed():
	Global.change_scene("GameScene") # start game
	Global.fish_no = fish_no
