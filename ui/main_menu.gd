extends Control


func _ready() -> void:
	populate_levels()
	pass


func populate_levels():
	var level_dir = ResourceLoader.list_directory(Game.LEVEL_DIRECTORY)
	for file in level_dir:
		if ResourceLoader.exists(Game.LEVEL_DIRECTORY + file):
			if file.get_slice(".", 1) == "tscn":
				var level_button = Button.new()
				level_button.text = "Level" + file.get_slice(".", 0)
				level_button.pressed.connect( func():
					Game.start_level(file.get_slice(".", 0))
					)
				%LevelContainer.add_child(level_button)
				#print("aplad")
				#print(file)
	pass
