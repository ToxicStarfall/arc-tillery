class_name SaveData
extends Resource

const SAVE_DATA_PATH = "user://save_data.tres"


var levels = []


func setup():
	pass


## Loads and applies save data if available.
func load():
	if ResourceLoader.exists(SAVE_DATA_PATH):
		print("Previous Save")
		var save_data = ResourceLoader.load(SAVE_DATA_PATH)
		self.levels = save_data.levels
	else:
		print("New Save")
		var level_dir = ResourceLoader.list_directory(Game.LEVEL_DIRECTORY)

		for file in level_dir:
			if file.ends_with(".tscn"):
				var level_data = LevelData.new()
				level_data.id = file.split(".")[0]
				levels.append(level_data)
		save()


## Saves save data.
func save():
	ResourceSaver.save(self, SAVE_DATA_PATH)


func save_level(_level: Level):
	#var level_data = {}
	#level_data.set("attempts", level.attemtps)
	#level_data.set("high_score", level.high_score)

	#levels.set(int(level.get_level_id()), level_data)
	pass


func sync_level(level_data: LevelData):
	print(levels)
	var current_data = levels.get(level_data.id)

	if current_data.high_score < level_data.high_score:
		current_data.high_score = level_data.high_score
