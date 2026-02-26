class_name Weapon
extends StaticBody2D


#@warning_ignore_start("unused_signal")
#signal weapon_fired (projectile: Projectile)

@export var disabled := false

@export_enum("Gunpowder:gunpowder", "Energy:energy") var power_type = "Gunpowder"
@export_range(10.0, 100.0) var default_power = 100.0
@export_range(0.0, 90.0) var default_angle = 0.0
var power = default_power
var current_angle = default_angle

@export var projectile_scene: PackedScene
@export var projectile_speed: float = 100.0  ## Projectile launch speed in metres (100px/metre).
#var projectiles: Array[Projectile] = []
#@export var projectile_weight: float = 1.5  ## Projectile weight in kilograms (kg).


func _ready() -> void:
	Events.weapon_fire_requested.connect( _on_fire_requested )
	Events.weapon_angle_change_requested.connect( _on_angle_change_requested )
	Events.weapon_power_change_requested.connect( _on_power_change_requested )
	# Init default values
	Events.weapon_angle_change_requested.emit(0.0)
	Events.weapon_power_change_requested.emit(10.0)
	#print("weapon ready")
	pass


func _on_fire_requested():
	# Level controls the ammo

	var new_projectile: RigidBody2D = projectile_scene.instantiate()
	new_projectile.position = $ProjectilePoint.position
	Events.weapon_fired.emit( new_projectile )

	var vel = Vector2.from_angle(deg_to_rad(current_angle) * -1) * projectile_speed #* 100
	#vel = vel * (power/100)
	vel = vel * (power)
	new_projectile.apply_central_force( vel * projectile_speed )


func _on_angle_change_requested( new_angle: float ):
	current_angle = new_angle
	$PivotPoint.rotation = deg_to_rad(90.0 - new_angle)
	Events.weapon_angle_changed.emit( current_angle )


func _on_power_change_requested( new_power: float ):
	power = new_power
	Events.weapon_power_changed.emit( power )
