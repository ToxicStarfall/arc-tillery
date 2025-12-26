extends Node


var UI: CanvasLayer
var World: Node2D

var ammo := 3
var current_weapon: Weapon
var last_projectile: Projectile

var gravity := Vector2(0.0, 980.0)

var Camera: Camera2D



func _ready() -> void:
	World = get_tree().root.get_node("Main/World")
	Camera = World.get_node("Camera2D")

	UI = get_tree().root.get_node("Main/UI")

	current_weapon = World.get_node("Weapon")
	current_weapon.weapon_fired.connect( _on_weapon_fired )
	UI.get_node("%FireButton").pressed.connect( current_weapon.fire )


func _on_weapon_fired(projectile: Projectile):
	World.add_child(projectile)
	last_projectile = projectile
	Camera.reparent(last_projectile)
	Camera.align()
	Camera.position = Vector2.ZERO  # Re-center camera onto projectile


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		Camera.zoom = (Camera.zoom + (Vector2.ONE * 0.01)).minf(2.0)
	if event.is_action_pressed("zoom_out"):
		Camera.zoom = (Camera.zoom - (Vector2.ONE * 0.01)).maxf(0.01)
