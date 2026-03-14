extends Node


const LEVEL_DIRECTORY = "res://world/levels/"
const PIXELS_PER_METER = 64

var IMPACT_PARTICLES = {
	#"GRASS": ResourceLoader.load("res://effects/particles/grass_impact.tscn")
}


var UI: CanvasLayer
var Drawers: CanvasLayer
var World: Node2D
var Camera: Camera2D

var current_level: Level
var current_weapon: Weapon

var save_data = SaveData.new()

# Toggles
var splash = false
var preloader = true


func _ready() -> void:
	_setup()

	#start_level("0")
	pass


func _setup():
	# Connect Signals
	Events.game_loading_started.connect( _on_game_loading_started )
	Events.level_completed.connect( _on_level_completed )

	var Main = get_tree().root.get_node("Main")
	UI = Main.get_node("UI")
	Drawers = Main.get_node("Drawers")
	World = Main.get_node("World")

	save_data.load_data()


func _on_game_loading_started():
	await _preloader()
	Events.game_loading_ended.emit()


func _preloader():
	var Loader = get_tree().root.get_node("Main/Loader")
	var queue = Loader.get_child_count()

	for child in Loader.get_children():
		child.emitting = true
		#await child.finished
		queue -= 1
	if queue == 0:
		return
		#print("queue ended")
		#pass


func start_level(level_id: String):
	end_level()  # Ends the previous level if available

	var level: Level = get_level(level_id).instantiate()
	current_level = level
	World.add_child(level)
	Camera = level.Camera

	Game.World.show()
	level.start()


func end_level():
	if current_level:
		World.remove_child(current_level)
		current_level.end()
		# Clear references
		current_level.queue_free()
		current_level = null


func home():
	end_level()
	Game.World.hide()


func retry_level():
	start_level( current_level.get_level_id() )


func next_level():
	var level_id = str(str_to_var(current_level.get_level_id()) + 1)
	if has_level(level_id):
		start_level(level_id)


# Returns the the level scene associated with level_id.
func get_level(level_id: String) -> PackedScene:
	var level_scene = load(LEVEL_DIRECTORY + "%s.tscn" % [level_id])
	return level_scene

# Returns true if level_id exists in the level directory.
func has_level(level_id: String) -> bool:
	return ResourceLoader.exists(LEVEL_DIRECTORY + "%s.tscn" % [level_id])


func _on_level_completed(level: Level):
	var level_data = level.get_save_data()
	save_data.sync_level(level_data)
	save_data.save()
