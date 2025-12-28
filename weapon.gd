class_name Weapon
extends StaticBody2D


@warning_ignore_start("unused_signal")
signal weapon_fired (projectile: Projectile)


@export_enum("Gunpowder:gunpowder", "Energy:energy") var power_type = "Gunpowder"
@export_range(10.0, 100.0) var power_level_default = 100.0
var power_level = power_level_default

@export var projectile: PackedScene
@export var projectile_speed: float = 100.0  ## Projectile launch speed in metres (100px/metre).
#@export var projectile_weight: float = 1.5  ## Projectile weight in kilograms (kg).

var default_angle: float = 45.0
var current_angle = default_angle



func fire():
	var new_projectile: RigidBody2D = projectile.instantiate()
	new_projectile.position = $ProjectilePoint.position
	weapon_fired.emit( new_projectile )

	var vel = Vector2.from_angle(deg_to_rad(current_angle) * -1) * projectile_speed * 100
	vel = vel * (power_level/100)
	new_projectile.apply_central_force( vel * projectile_speed )
	pass


#func change_angle():
	#pass
