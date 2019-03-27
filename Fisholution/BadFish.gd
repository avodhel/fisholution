extends RigidBody2D

export (int) var min_speed
export (int) var max_speed


func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # if bad fish goes off the screen delete bad fish
