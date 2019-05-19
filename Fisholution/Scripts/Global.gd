extends Node

var bubbleffect = ResourceLoader.load("res://Scenes/UI/Bubbleffect.tscn")

var fish_no

#SCENE MANAGER
const SCENE_PATH = "res://Scenes/"

func _bubbleffect(): # bubble transition
	var instance_bubble = bubbleffect.instance()
	add_child(instance_bubble)
	get_node("../Global/Bubbleffect").play_effect()

func change_scene(scene_name):
	_bubbleffect()
	yield(get_tree().create_timer(0.65), "timeout")
	call_deferred("_deferred_change_scene", scene_name)
	
func _deferred_change_scene(scene_name):
	var path = SCENE_PATH + scene_name + ".tscn"
	var root = get_tree().get_root()
	var current = root.get_child(root.get_child_count() - 1)
	current.free()
	var scene_resource = ResourceLoader.load(path)
	var new_scene = scene_resource.instance()
	get_tree().get_root().add_child(new_scene)
	get_tree().set_current_scene(new_scene)

#PLAYER DATA
const SAVE_FILE_PATH = "user://playerdata.save"

func save_highscore(score):
	if load_highscore() > score:
		return
	
	var save_file = File.new()
	save_file.open(SAVE_FILE_PATH, File.WRITE)
	var data = {
		highscore = score
	}
	save_file.store_line(to_json(data))
	save_file.close()

func load_highscore():
	var save_file = File.new()
	if !save_file.file_exists(SAVE_FILE_PATH):
		return 0
		
	var highscore
	
	save_file.open(SAVE_FILE_PATH, File.READ)
	var data  = parse_json(save_file.get_line())
	return data["highscore"]

