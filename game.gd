extends Node


var UI: CanvasLayer
var World: Node2D

var ammo = 3
var current_weapon

var projectile_speed := 200.0
#var gravity := Vector2(0.0, 10.0)
var gravity := Vector2(0.0, 980.0)

var vertical_angle = 45
var horizontal_angle = 0


func _ready() -> void:
	World = get_tree().root.get_node("Main/World")
	UI = get_tree().root.get_node("Main/UI")

	current_weapon = World.get_node("Weapon")
	current_weapon.weapon_fired.connect( _on_weapon_fired )
	UI.get_node("%FireButton").pressed.connect( current_weapon.fire )


func _on_weapon_fired(projectile: Projectile):
	#var projectile: RigidBody2D = preload("res://projectiles/projectile.tscn").instantiate() #Projectile.new()
	#projectile.position = World.get_node("%ProjectilePoint").position
	#var velocity = Vector2(50 * 100, -80 * 100)
	#print(Vector2.from_angle(vertical_angle))
	#var velocity = Vector2.from_angle(vertical_angle) * projectile_speed * 100

	World.add_child(projectile)
	#projectile.apply_central_force( velocity )
	pass
