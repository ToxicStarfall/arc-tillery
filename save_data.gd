class_name SaveData
#extends Resource
extends Object

#const SAVE_DATA_PATH = "user://save_data.tres"
const SAVE_DATA_PATH = "user://save_data.cfg"


var config = ConfigFile.new()


func setup():
	pass


## Loads and applies save data if available.
func load_data():
	#if ResourceLoader.exists(SAVE_DATA_PATH):
	var err = config.load(SAVE_DATA_PATH)
	if err == Error.OK:
		print("Previous Save")
		# Apply save data here
		pass
	# Initialize new config file for save data.
	elif err == Error.ERR_FILE_NOT_FOUND:
		print("New Save")
		var level_dir = ResourceLoader.list_directory(Game.LEVEL_DIRECTORY)

		for file in level_dir:
			if file.ends_with(".tscn"):
				var level_id = file.split(".")[0]
				var level_data = {}
				level_data.set("id", level_id)
				level_data.set("high_score", 0)
				config.set_value("levels", level_id, level_data)
		save()
	else:
		push_error("Error while loading save data: ", err)


## Saves save data.
func save():
	var err = config.save(SAVE_DATA_PATH)
	if !err == Error.OK:
		push_error("Error while saving save data: ", err)


func save_level(_level: Level):
	#var level_data = {}
	#level_data.set("attempts", level.attemtps)
	#level_data.set("high_score", level.high_score)

	#levels.set(int(level.get_level_id()), level_data)
	pass


func sync_level(level_data: Dictionary):
	print("syncing level")
	print(level_data.high_score)
	var current_data = config.get_value("levels", level_data.id)

	if current_data.high_score < level_data.high_score:
		current_data.high_score = level_data.high_score

	config.set_value("levels", level_data.id, current_data)
	pass
