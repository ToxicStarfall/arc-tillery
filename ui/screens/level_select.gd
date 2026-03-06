extends Control


const level_button_scene = preload("res://ui/screens/level_button.tscn")



func _ready() -> void:
	populate_levels()


func populate_levels():
	var level_dir = ResourceLoader.list_directory(Game.LEVEL_DIRECTORY)

	for file in level_dir:
		if ResourceLoader.exists(Game.LEVEL_DIRECTORY + file):
			if file.get_slice(".", 1) == "tscn":
				var level_id = file.get_slice(".", 0)

				var level_button = level_button_scene.instantiate()
				level_button.text = "LEVEL " + file.get_slice(".", 0)
				level_button.score = Game.save_data.config.get_value("levels", level_id).high_score
				level_button.pressed.connect( func():
					Game.start_level(file.get_slice(".", 0))
					)
				%LevelContainer.add_child(level_button)


func refresh():
	for child in  %LevelContainer.get_children():
		child.score = Game.save_data.config.get_value("levels", str(child.get_index())).high_score
