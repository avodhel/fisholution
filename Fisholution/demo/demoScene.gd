extends Node2D

export (Array, PackedScene) var demo_objects

onready var demo_spawn_loc = $Path2D/PathFollow2D
onready var object_timer = $ObjectTimer
onready var demoChart = $demoHud/demoChart

func _ready():
	pass

func _on_ObjectTimer_timeout():
	demo_spawn_loc.set_offset(randi())
	var demo_object = demo_objects[randi() % demo_objects.size()].instance()
	add_child(demo_object)
	demo_object.position = demo_spawn_loc.global_position
	if demo_object.is_in_group("blue"):
		demoChart.increase_or_reduce("demo1", "inc")
	if demo_object.is_in_group("green"):
		demoChart.increase_or_reduce("demo2", "inc")
	if demo_object.is_in_group("purple"):
		demoChart.increase_or_reduce("demo3", "inc")
