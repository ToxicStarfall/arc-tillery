extends Area2D
class_name Interactable


var spring_force = 128.0 * 8.0


func _ready() -> void:
	body_entered.connect( _on_body_entered )
	pass


func _on_body_entered(body: Node2D):
	if body is RigidBody2D:
		#$ForceDirection.target_position.rotated( rotation )
		body.apply_impulse( $ForceDirection.target_position.normalized().rotated( rotation ) * spring_force * body.mass, Vector2.ZERO)
		if has_node("AudioStreamPlayer2D"): $AudioStreamPlayer2D.play()

		$Sprite2D.texture = preload("res://world/objects/interactables/spring_down.svg")
		await get_tree().create_timer(0.5).timeout
		$Sprite2D.texture = preload("res://world/objects/interactables/spring.svg")
	#if body is Projectile:
		#pass
