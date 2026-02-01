class_name Collectable
extends Area2D


#signal collected


var time = 0.0  # Used for floating animation

var collected: bool = false  ## Used internally to prevent double collection.


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
		if !collected:
			collected = true
			_collected()


func _collected():
	#if has_node("CPUParticles2D"):
		#$CPUParticles2D.emitting = true  # Requires oneshot
	pass
