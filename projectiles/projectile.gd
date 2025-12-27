class_name Projectile
extends RigidBody2D
#extends Area2D


#var velocity := Vector2.ZERO
@export var impact_force: float = 100.0
@export var impact_range: float = 4.0  ## Impact effect area in meters
@export var impact_falloff: float = 0.3  ## Force percentage per every meter from impact


func _ready() -> void:
	$Area2D/CollisionShape2D.shape.radius = impact_range * 100
	pass


#func _physics_process(delta: float) -> void:
	#print(position)
	#position += velocity * delta
	#pass


#func impact():
	#$Camera2D.reparent(self.get_parent())
	#queue_free()
	#pass
