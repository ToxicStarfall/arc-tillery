extends Area2D


var time = 0.0


func _physics_process(delta: float) -> void:
	rotate(deg_to_rad(18 * delta))
	#print(sin(10 * delta) * 0.1)
	#position.y += sin(delta * 1.0) * 10
	time += delta * 1.0
	position.y += sin(time) * 0.25
	pass


func _on_body_entered(body: Node2D) -> void:
	if body is Projectile:
		print("hit")
	pass # Replace with function body.
