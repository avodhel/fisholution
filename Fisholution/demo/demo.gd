extends Area2D

signal object_died(whichobject)

export (float) var min_scale = 0.5
export (float) var max_scale = 2.5

onready var coll = $CollisionShape2D

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
	position += ((velocity * delta).normalized() * 0.5).rotated(direction)

#func _on_demo_body_entered(body):
#	print(body.name)

func _on_demo_area_entered(area):
	if area.scale > scale:
#		hide()
#		coll.disabled = true

		if self.is_in_group("demo1"):
			emit_signal("object_died", "demo1")
		elif self.is_in_group("demo2"):
			emit_signal("object_died", "demo2")
		elif self.is_in_group("demo3"):
			emit_signal("object_died", "demo3")
		
		call_deferred("free")