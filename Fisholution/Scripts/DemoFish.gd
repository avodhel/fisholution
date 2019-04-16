extends Node2D

export (int) var min_speed
export (int) var max_speed

func _ready():
	var rand_scale = rand_range(0.5, 3)
	var rand_vector = Vector2(rand_scale, rand_scale)
	scale = rand_vector

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # if bad fish goes off the screen delete bad fish
	

