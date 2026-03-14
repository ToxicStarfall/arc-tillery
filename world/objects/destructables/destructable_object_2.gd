
#extends CollisionChecker
extends RigidBody2D
class_name DestructableObject2


@export var particle_scene: PackedScene

@export var durability: float = 100.0
@export var resistance: float = 20.0
@export var threshhold: float = 1024.0

var collision_monitor: CollisionMonitor
var collision_speed_threshold = 256.0


func _ready():
	#super()
	collision_monitor = CollisionMonitor.new()
	#Events.weapon_fired.connect( _on_weapon_fired )
	pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var contact_position = collision_monitor.integrate_forces(state, collision_speed_threshold)
	if contact_position:
		particle_effect(contact_position)


func _on_weapon_fired(_projectile: Projectile):
	#queue_reset = true
	#sleeping = false
	pass


func particle_effect(collision_point: Vector2):
	#print("patrilaf")
	var p = particle_scene.instantiate()
	#p.amount = 30
	get_tree().get_root().add_child(p)
	p.global_position = collision_point
	#if (p is CPUParticles2D):
	p.restart()
	pass
