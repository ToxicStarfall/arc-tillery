extends Node


const LEVEL_DIRECTORY = "res://world/levels/"

const PIXELS_PER_METER = 64

var UI: CanvasLayer
var Drawers: CanvasLayer
var World: Node2D
var Camera: Camera2D

var current_level: Level
var current_weapon: Weapon
var current_projectile: Projectile

#var targets: Array = []

var save_data



func _ready() -> void:
	_setup()

	#start_level("0")
	pass


func _setup():
	var Main = get_tree().root.get_node("Main")
	UI = Main.get_node("UI")
	Drawers = Main.get_node("Drawers")
	World = Main.get_node("World")


func start_level(level_id: String):
	end_level()  # Ends the previous level if available

	var level: Level = get_level(level_id).instantiate()
	current_level = level
	World.add_child(level)
	#Camera = World.get_node("Level/%Camera2D")
	Camera = level.Camera

	#current_weapon = level.current_weapon
	Game.World.show()
	level.start()


func end_level():
	if current_level:
		World.remove_child(current_level)
		current_level.end()
		current_level.queue_free()
		current_level = null


func home():
	end_level()
	Game.World.hide()
	#sceren_changed.emit()
	pass


func retry_level():
	start_level( current_level.get_level_id() )
	#end_level()


func next_level():
	var level_id = str(str_to_var(current_level.get_level_id()) + 1)
	#print(has_level( level_id ))
	if has_level( level_id ):
		start_level( level_id )


# Returns the the level scene associated with level_id.
func get_level(level_id: String) -> PackedScene:
	var level_scene = load(LEVEL_DIRECTORY + "%s.tscn" % [level_id])
	return level_scene

# Returns true if level_id exists in the level directory.
func has_level(level_id: String) -> bool:
	return ResourceLoader.exists("res://world/levels/%s.tscn" % [level_id])
