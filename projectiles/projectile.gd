class_name Projectile
extends RigidBody2D
#extends CharacterBody2D


@export var impact_force: float = 100.0
@export var impact_range: float = 4.0  ## Impact effect area in meters
@export var impact_falloff: float = 0.3  ## Force percentage per every meter from impact

#@onready var GrassParticles = ResourceLoader.load("res://effects/particles/grass_impact.tscn")


var velocity := Vector2.ZERO
#var last_velocity := Vector2.ZERO


func _ready() -> void:
	body_entered.connect( _on_body_entered )
	#sleeping_state_changed.connect( _on_sleeping_state_changed )

	#$Area2D/CollisionShape2D.shape.radius = impact_range * 100
	pass


#func _integrate_forces(state: PhysicsDirectBodyState2D) -> void:
	#if state.get_contact_count() > 1:
		#print(state.get_contact_collider_object(0), " @ ", state.get_contact_local_position(0))
		#var contact_local_pos = state.get_contact_local_position(0)
		#var contact_local_vel = state.get_contact_local_velocity_at_position(0)
		#print("velocity_at_local_position ", state.get_velocity_at_local_position(contact_local_pos))
		#print("contact_local_vel ", contact_local_vel)
		#print(state.get_contact_collider_velocity_at_position(0))
		#print("")
		#pass


func _physics_process(_delta: float) -> void:
	#var collision: KinematicCollision2D = move_and_collide(linear_velocity * delta, true)
	#if collision:
		#print(collision.get_travel())
		#print(collision.get_collider_velocity())

	#if !sleeping:
		#if Game.current_level.tracked_projectile:
			#Game.Drawers.ProjectileTrail.queue_redraw()
			#print(Game.Drawers.ProjectileTrail.points.append( self.position ))
			#var a = Game.Drawers.ProjectileTrail.points.duplicate()
			#a.append( self.position )
			#Game.Drawers.ProjectileTrail.points = a
			pass


func _on_body_entered(body: Node):
	#for body in get_colliding_bodies():
	if body is Ground:
		_impact( linear_velocity )
	pass


func _impact(force: Vector2):
	var speed: float = force.length() / Game.PIXELS_PER_METER
	#print("impact force: ", force, "  speed: ", speed, " ")

	#var collision: KinematicCollision2D = move_and_collide(force, true)
	#if collision:
		#print( collision.get_remainder() )

	var impact_scaler: float = 1.0
	if rad_to_deg(angular_velocity) > 720.0:
		#print("angular vel particles")
		impact_scaler = rad_to_deg(angular_velocity) / 720.0
	elif speed >= 3.0:  # 3m/s threshold for impact particles.
		#print("linear vel particles")
		impact_scaler = speed / 3.0

	#print(int(impact_scaler))
	if has_node("GrassImpactParticles"):
		var a = $GrassImpactParticles.duplicate()
		#var a = ResourceLoader.load("res://effects/particles/grass_impact.tscn").instantiate()
		#var a = GrassParticles.instantiate()
		a.amount = int(a.amount * impact_scaler)
		print("particles")
		if a.amount > 1:
			self.add_child(a)
			a.emitting = true
			a.finished.connect( func(): a.queue_free() )


#func _on_sleeping_state_changed():
	#print("sleep stae")
	#pass
