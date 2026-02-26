class_name Collectable
extends Area2D


@warning_ignore("unused_signal")
signal collected


var collectable: bool = true  ## Used internally to prevent double collection.
var time = 0.0  # Used for floating animation


func _ready() -> void:
	body_entered.connect( _on_body_entered )


func _physics_process(delta: float) -> void:
	# Collectable floating animation
	rotate(deg_to_rad(18 * delta))
	#print(sin(10 * delta) * 0.1)
	#position.y += sin(delta * 1.0) * 10
	time += delta * 1.0
	position.y += sin(time) * 0.15


func _on_body_entered(body: Node2D) -> void:
	if body is Projectile:
		if collectable:
			collectable = false
			_collected()


# Collection effects
func _collected():
	#if has_node("CPUParticles2D"):
		#$CPUParticles2D.emitting = true  # Requires oneshot
	pass
