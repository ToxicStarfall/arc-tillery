
#extends CollisionChecker
extends RigidBody2D
class_name DestructableObject2


@export var particle_scene: PackedScene

@export var durability: float = 100.0
@export var resistance: float = 20.0
@export var threshhold: float = 640.0

var collision_monitor: CollisionMonitor
var collision_speed_threshold = 256.0


func _ready():
	#super()
	collision_monitor = CollisionMonitor.new()
	#Events.weapon_fired.connect( _on_weapon_fired )
	pass


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	var collision = collision_monitor.integrate_forces(state, collision_speed_threshold)
	if collision:
		damage_force(collision.velocity)
		particle_effect(collision)


func _on_weapon_fired(_projectile: Projectile):
	#queue_reset = true
	#sleeping = false
	pass


func damage_force(force: Vector2):
	var magnitude = force.length()
	if magnitude * (resistance / 100) > threshhold or durability <= 0:
	#if force.length() > threshhold:
		queue_free()
	else:
		durability -= magnitude * (resistance / 100)



func particle_effect(collision: Dictionary):
	var p = particle_scene.instantiate()
	p.amount = 4 + (collision.velocity.length() / Game.PIXELS_PER_METER)
	p.global_position = collision.position

	#get_tree().get_root().add_child(p)
	Game.current_level.add_child(p)

	p.emitting = true
	p.finished.connect( func(): p.queue_free() )
	#Events.particles_emitted.emit(p, collision.position)
	pass
