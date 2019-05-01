extends Area2D

export (float) var min_scale = 0.5
export (float) var max_scale = 2.5

var velocity = Vector2()
var direction 
var rand_scale
var rand_vector

func _ready():
	randomize()
	direction = rand_range(-90, 90)
	rand_scale = rand_range(min_scale, max_scale)
	rand_vector = Vector2(rand_scale, rand_scale)
	scale = rand_vector

func _process(delta):
	velocity.y -= 1
	position += ((velocity * delta).normalized() * 1).rotated(direction)

#func _on_demo_body_entered(body):
#	print(body.name)

func _on_demo_area_entered(area):
	if area.scale > scale:
		call_deferred("free")
	elif area.scale < scale:
		area.call_deferred("free")
