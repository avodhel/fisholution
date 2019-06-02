extends Node

var fish_no = 0 #which fish chosen
var which_mode #which mode chosen
var eaten_fish_count = 0 #how many fish eaten by our fish (this value used for score calculate)

func _ready():
#	reset_highscore()
	_bubbleffect("instance") #bubble transition

#FISHES AND ENEMIES
func die_effect(effect, object):
	effect.interpolate_property(object, 'scale', object.get_scale(), Vector2(0, 0), 0.05, 
                                Tween.TRANS_QUAD, Tween.EASE_OUT)

#BUBBLE TRANSITION
var bubbleffect = ResourceLoader.load("res://Scenes/UI/Bubbleffect.tscn")

func _bubbleffect(condition): # bubble transition
	match condition:
		"instance":
			var instance_bubble = bubbleffect.instance()
			add_child(instance_bubble)
		"play":
			get_node("../Global/Bubbleffect").play_effect()

#SCENE MANAGER
const SCENE_PATH = "res://Scenes/"

func change_scene(scene_name):
	_bubbleffect("play") #play bubble effect between scenes
	yield(get_tree().create_timer(0.65), "timeout")
	call_deferred("_deferred_change_scene", scene_name)
	if get_tree().paused == true: # if game paused
		get_tree().paused = false # unpaused 

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

func reset_highscore():
	var dir = Directory.new()
	dir.remove(SAVE_FILE_PATH)