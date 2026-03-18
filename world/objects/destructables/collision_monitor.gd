# CREDIT
# @sweatix
# https://forum.godotengine.org/t/determining-the-exact-global-position-of-a-collision-with-rigidbody2d-body-shape-entered/77007/2

extends Resource
class_name CollisionMonitor

@warning_ignore("unused_signal")
signal collision_detected


@export var effect_speed_threshold = 256.0

# State history
var transform_old: Transform2D
var velocity_old: Vector2
var angular_velocity_old: float
# NOTE: For extended use, it would be best to wrap this kind of data in a class

# Testing variables
var queue_reset: bool
var reset_transform: Transform2D


func _init() -> void:
	#reset_transform = global_transform
	Events.weapon_fired.connect( _on_weapon_fired )


func _on_weapon_fired(_projectile: Projectile):
	#queue_reset = true
	#print("AJNSD")
	#sleeping = false
	pass

#func _process(_delta):
	#if Input.is_action_just_pressed("ui_accept"):
		#queue_reset = true
		#sleeping = false


func integrate_forces(state: PhysicsDirectBodyState2D, speed_threshold: float):
	#var contact_position: Vector2  # Custom
	var collision := {}  # Custom

	if (queue_reset):
		#state.transform = reset_transform
		state.linear_velocity = Vector2.ZERO
		state.angular_velocity = 0
		queue_reset = false

	for i in range(state.get_contact_count()):
		# NOTE: state.get_contact_local_position() is in the local space of
		#		the body that is collided with. Therefore, it is not useful.
		var to_collision_point = state.get_contact_collider_position(i) - state.transform.origin
		var collision_velocity = compute_velocity_at_point(to_collision_point, state, transform_old, velocity_old, angular_velocity_old)
		#print("Collision speed(%d): %s" % [i, collision_velocity.length()])

		if (collision_velocity.length() >= speed_threshold):
			# Spawn, position and play the particle instance
			#var p = particle_prefab.instantiate()
			#get_tree().get_root().add_child(p)
			#p.global_position = state.get_contact_collider_position(i)
			#if (p is CPUParticles2D):
				#p.restart()

			#contact_position = state.get_contact_collider_position(i)  # Custom
			collision["position"] = state.get_contact_collider_position(i)
			collision["velocity"] = collision_velocity
			pass

	# Update the state-history variables
	transform_old = state.transform
	velocity_old = state.linear_velocity
	angular_velocity_old = state.angular_velocity

	return collision  # Custom


func compute_velocity_at_point(local_point: Vector2, state: PhysicsDirectBodyState2D, old_transform: Transform2D, old_velocity: Vector2, old_angular_velocity: float) -> Vector2:
	#====================================================================================
	# Compute point velocity based on the previous state (velocity, and angular velocity)
	# NOTE: The immediate state of the object is not useful for this use-case; the collision
	# 		forces have already been applied to the rigidbody.
	#====================================================================================

	## Compute the velocity resulting purely from the angular velocity
	### The difference in rotation between the two states (current and old state)
	var rot_diff = state.transform.get_rotation() - old_transform.get_rotation()
	### The vector that is "tangent" to the position (from the local point provided).
	var tangent = local_point.rotated(old_transform.get_rotation() + PI / 2.0).normalized()
	### The velocity at the point modulated by the angular_velocity and distance from the center.
	var velocity_rot = tangent.rotated(rot_diff) * old_angular_velocity * local_point.length()

	return old_velocity + velocity_rot
