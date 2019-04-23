extends ParallaxLayer

export (Array, PackedScene) var sea_objects

var screensize_x
var screensize_y

func _ready():
	screensize_x = get_viewport_rect().size.x
	screensize_y = get_viewport_rect().size.y
	motion_mirroring.x = screensize_x
	motion_mirroring.y = screensize_y
	_spawn_sea_objects()

func _spawn_sea_objects():
	randomize()
	for counter in range(rand_range(75, 105)):
		var position_x = rand_range(screensize_x - (screensize_x - 1), screensize_x)
		var position_y = rand_range(screensize_y - (screensize_y - 1), screensize_y)
		var sea_object = sea_objects[randi() % sea_objects.size()].instance()
		if sea_object.is_in_group("rare_sea_weed"):
			if rand_range(0, 100) > 80:
				add_child(sea_object)
			else:
				continue
		elif sea_object.is_in_group("common_sea_weed"):
			add_child(sea_object)
		else:
			add_child(sea_object)
		sea_object.position = Vector2(position_x, position_y)