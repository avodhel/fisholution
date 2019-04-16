extends Node

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

