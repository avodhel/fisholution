extends Node

onready var animation = $ParallaxBackground/ParallaxLayer/Fade/animation

func _ready():
	randomize()
	var rand_percentage = rand_range(0, 100)
	if rand_percentage < 50:
		animation.play("day_to_night")
	else:
		animation.play("night_to_day")

func _on_animation_animation_finished(anim_name):
	if anim_name == "day_to_night":
		animation.play("night_to_day")
	elif anim_name == "night_to_day":
		animation.play("day_to_night")
