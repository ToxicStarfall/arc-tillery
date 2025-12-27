class_name DestructableObject
extends RigidBody2D


@export var durability_max = 10.0
var durability = durability_max


func _ready():
	pass


func _on_body_entered(body: Node) -> void:
	if body is Projectile:
		#print("body")

		await Game.camera_focus_weapon()
		self.queue_free()
		body.queue_free()


#func _on_body_shape_entered(body_rid: RID, body: Node, body_shape_index: int, local_shape_index: int) -> void:
	#if body is Projectile:
		#print("bodyshape")
