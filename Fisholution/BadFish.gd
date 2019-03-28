extends RigidBody2D

export (int) var min_speed
export (int) var max_speed

func _ready():
	var rand_scale = rand_range(0.5, 3)
	var rand_vector = Vector2(rand_scale, rand_scale)
	$Sprite.scale = rand_vector
	$CollisionShape2D.scale = rand_vector
	$CollisionShape2D.rotation_degrees = 90

func _process(delta):
	$Sprite/AnimationPlayer.play("right")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # if bad fish goes off the screen delete bad fish
