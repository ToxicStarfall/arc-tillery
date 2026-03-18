extends Area2D


var spring_force = 128.0 * 8.0


func _ready() -> void:
	body_entered.connect( _on_body_entered )
	pass


func _on_body_entered(body: Node2D):
	if body is RigidBody2D:
		body.apply_impulse( $ForceDirection.target_position.normalized() * spring_force * body.mass, Vector2.ZERO)
		if has_node("AudioStreamPlayer2D"): $AudioStreamPlayer2D.play()
	#if body is Projectile:
		#pass
