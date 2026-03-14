class_name DestructableObject
extends RigidBody2D


@export var threshhold: float = 1000.0
@export var resistance: float = 100.0
@export var durability_max: float = 10.0
var durability = durability_max


func _ready():
	body_entered.connect( _on_body_entered )
	#body_shape_entered


func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	for i in state.get_contact_count():
		var collider_object = state.get_contact_collider_object(i)
		#var collider_id = state.get_contact_collider_id(i)

		var raw_force_vector = state.get_contact_impulse(0) / state.step
		#print(state.get_contact_impulse(0), raw_force_vector)
		#var impact_force = (state.get_contact_impulse(0) / state.step)# / Game.PIXELS_PER_METER
		#var force_vector = state.get_contact_impulse(i)
		#var force_magnitude = force_vector.length()
		#print("Force - vec: ", force_vector, "  mag: ", force_magnitude)

		if raw_force_vector != Vector2.ZERO:
			#apply_impact_force(force_vector)
			#print(state.get_contact_collider_velocity_at_position(0))
			#var contact_local_position = state.get_contact_local_position(i)
			#var contact_local_vel = state.get_contact_local_velocity_at_position(0)
			#print("contact_local_position ", contact_local_position)
			#print("contact_local_velocity ", contact_local_vel)
			#print("")
			pass
	pass


func _on_body_entered(body: Node) -> void:
	if body is Projectile:
		#print("body")
		#self.queue_free()
		#body.queue_free()
		pass


#func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	#if body is Projectile:
		#print("bodyshape")


func apply_impact_force(raw_force: Vector2):
	# sasd  jkj testong if wlly worksaakatime act
	# anjsdk apples are the sun
	var force = raw_force / Game.PIXELS_PER_METER
	print(force)
