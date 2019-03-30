extends RigidBody2D

export (int) var min_speed
export (int) var max_speed

var sprite_scale

func _ready():
	var rand_scale = rand_range(0.5, 3)
	var rand_vector = Vector2(rand_scale, rand_scale)
	$Sprite.scale = rand_vector
#	$CollisionShape2D.scale = rand_vector
	$mouthColl.scale = rand_vector
	$bodyColl.scale = rand_vector
	sprite_scale = $Sprite.scale

func _process(delta):
	$Sprite/AnimationPlayer.play("right")

func _on_VisibilityNotifier2D_screen_exited():
	queue_free() # if bad fish goes off the screen delete bad fish

