extends Control


const level_button_scene = preload("res://ui/screens/level_button.tscn")



func _ready() -> void:
	%BackButton.pressed.connect( func(): self.hide() )
	%HelpButton.pressed.connect( func(): %Instructions.show() )

	Events.game_reset.connect( func():
		refresh()
		if Game.save_data.config.get_value("", "instructions") == false:
			%Instructions.show()
		else:
			%Instructions.hide()
		)

	populate_levels()

	if !Game.dev: %LevelContainer.get_child(0).hide()

	await Events.game_ready
	if Game.save_data.config.get_value("", "instructions") == false:
		%Instructions.show()
	else:
		%Instructions.hide()


func populate_levels():
	var level_dir = ResourceLoader.list_directory(Game.LEVEL_DIRECTORY)

	# Filters non tscn files,
	# Sorts level files names numerically, and returns as str
	var a = Array(level_dir).filter( func(elem): if elem.get_slice(".", 1) == "tscn": return elem )
	a = a.map( func(elem): return int(elem.get_slice(".", 0)) )
	a.sort()
	#level_dir = a.map( func(elem): return str(elem, ".tscn") )
	level_dir = a.map( func(elem): return str(elem) )

	for file in level_dir:
		#if ResourceLoader.exists(Game.LEVEL_DIRECTORY + file):
			#if file.get_slice(".", 1) == "tscn":
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
