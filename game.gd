extends Node



const PIXELS_PER_METER = 64

var UI: CanvasLayer
var World: Node2D
var Camera: Camera2D

var current_level: Level
var current_weapon: Weapon
var current_projectile: Projectile

#var targets: Array = []

var save_data



func _ready() -> void:
	setup()

	start_level("0")
	pass


func setup():
	UI = get_tree().root.get_node("Main/UI")
	World = get_tree().root.get_node("Main/World")
	#Camera = World.get_node("%Camera2D")
	#current_weapon = World.get_node("Weapon")

	#Events.weapon_fired.connect( _on_weapon_fired )


func start_level(level_id: String):
	end_level()  # Ends the previous level if available

	var level: Level = load("res://world/levels/%s.tscn" % [level_id]).instantiate()
	current_level = level
	World.add_child(level)
	Camera = World.get_node("Level/%Camera2D")

	#current_weapon = World.get_node("Level/Weapon")
	current_weapon = level.current_weapon


func end_level():
	if current_level:
		World.remove_child(current_level)
		current_level.end()
		current_level.queue_free()
		current_level = null


func home():
	end_level()
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


func has_level(level_id: String) -> bool:
	return ResourceLoader.exists("res://world/levels/%s.tscn" % [level_id])


func _on_level_completed():
	pass

func _on_level_ended():
	pass


#func _on_weapon_fired(projectile: Projectile):
	#World.add_child(projectile)
	#if current_projectile: current_projectile.sleeping_state_changed.disconnect( _on_projectile_sleeping )
	#current_projectile = projectile
	#current_projectile.sleeping_state_changed.connect( _on_projectile_sleeping.bind(current_projectile) )
#
	#Camera.reparent(current_projectile)
	#Camera.position = Vector2.ZERO  # Re-center camera onto projectile
	#Camera.offset = Vector2.ZERO
	#pass


#func _on_projectile_sleeping(projectile):
	#if projectile.sleeping:
		#camera_focus_weapon()
	#pass


func _unhandled_input(event: InputEvent) -> void:
	var zoom_factor = 0.1
	if event is InputEventMouse and !event.factor == 1:
		#zoom_factor = event.factor
		zoom_factor = 0.01
		#print(zoom_factor)
			#print("trackpad?")

	if event.is_action_pressed("zoom_in"):
		Camera.zoom = (Camera.zoom + (Vector2.ONE * zoom_factor)).minf(1.5)
		World.get_node("%GridDrawer").queue_redraw()
	if event.is_action_pressed("zoom_out"):
		Camera.zoom = (Camera.zoom - (Vector2.ONE * zoom_factor)).maxf(0.1)
		World.get_node("%GridDrawer").queue_redraw()


func camera_focus_projectile():
	pass


#func camera_focus_weapon():
	##Camera.position_smoothing_enabled = false
	##Camera.reparent(current_weapon, true)
	#Camera.reparent(current_weapon)
	##Camera.position = projectile.global_position
#
	#var tween = get_tree().create_tween()
	#tween.tween_property(Camera, "position", Vector2.ZERO, 3)
	#await tween.finished
	##Camera.align()
