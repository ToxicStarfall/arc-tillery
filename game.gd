extends Node


var UI: CanvasLayer
var World: Node2D

var Camera: Camera2D

var ammo := 3
var current_weapon: Weapon
var current_projectile: Projectile

#var gravity := Vector2(0.0, 980.0)


func _ready() -> void:
	World = get_tree().root.get_node("Main/World")
	Camera = World.get_node("%Camera2D")

	UI = get_tree().root.get_node("Main/UI")

	current_weapon = World.get_node("Weapon")
	current_weapon.weapon_fired.connect( _on_weapon_fired )
	UI.get_node("%FireButton").pressed.connect( current_weapon.fire )


func _on_weapon_fired(projectile: Projectile):
	World.add_child(projectile)
	if current_projectile: current_projectile.sleeping_state_changed.disconnect( _on_projectile_sleeping )
	current_projectile = projectile
	current_projectile.sleeping_state_changed.connect( _on_projectile_sleeping.bind(current_projectile) )

	Camera.reparent(current_projectile)
	Camera.position = Vector2.ZERO  # Re-center camera onto projectile
	Camera.offset = Vector2.ZERO


func _on_projectile_sleeping(projectile):
	if projectile.sleeping:
		camera_focus_weapon()
	pass


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("zoom_in"):
		Camera.zoom = (Camera.zoom + (Vector2.ONE * 0.01)).minf(1.5)
	if event.is_action_pressed("zoom_out"):
		Camera.zoom = (Camera.zoom - (Vector2.ONE * 0.01)).maxf(0.1)


func camera_focus_projectile():
	pass


func camera_focus_weapon():
	#Camera.position_smoothing_enabled = false
	#Camera.reparent(current_weapon, true)
	Camera.reparent(current_weapon)
	#Camera.position = projectile.global_position

	var tween = get_tree().create_tween()
	tween.tween_property(Camera, "position", Vector2.ZERO, 3)
	await tween.finished
	#Camera.align()
