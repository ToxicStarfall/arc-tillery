extends Node


var UI: CanvasLayer
var World: Node2D

var ammo := 3
var current_weapon: Weapon

var gravity := Vector2(0.0, 980.0)



func _ready() -> void:
	World = get_tree().root.get_node("Main/World")
	UI = get_tree().root.get_node("Main/UI")

	current_weapon = World.get_node("Weapon")
	current_weapon.weapon_fired.connect( _on_weapon_fired )
	UI.get_node("%FireButton").pressed.connect( current_weapon.fire )


func _on_weapon_fired(projectile: Projectile):
	World.add_child(projectile)


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		var zoom: Vector2 = World.get_node("Camera2D").zoom
		World.get_node("Camera2D").zoom = (zoom + (Vector2.ONE * 0.01)).minf(2.0)
		#World.get_node("Camera2D").zoom += Vector2.ONE * 0.01).minf(2.0)
	if event.is_action_pressed("zoom_out"):
		var zoom: Vector2 = World.get_node("Camera2D").zoom
		World.get_node("Camera2D").zoom = (zoom - (Vector2.ONE * 0.01)).maxf(0.01)
