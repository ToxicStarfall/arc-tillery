class_name Projectile
extends RigidBody2D
#extends Area2D


#var velocity := Vector2.ZERO
var last_velocity := Vector2.ZERO
@export var impact_force: float = 100.0
@export var impact_range: float = 4.0  ## Impact effect area in meters
@export var impact_falloff: float = 0.3  ## Force percentage per every meter from impact


func _ready() -> void:
	#body_entered.connect( _on_body_entered )
	#sleeping_state_changed.connect( _on_sleeping_state_changed )

	#$Area2D/CollisionShape2D.shape.radius = impact_range * 100
	pass


func _physics_process(_delta: float) -> void:
	#if !sleeping:
		#last_velocity = linear_velocity
		#print("a")
	#position += velocity * delta
	pass


#func impact():
	#$Camera2D.reparent(self.get_parent())
	#queue_free()
	#pass


func _on_body_entered(_body: Node):
	#if body is Ground:
	print("body")
	print(linear_velocity)
	pass


func _on_sleeping_state_changed():
	print("sleep stae")
	print(linear_velocity)
	print(last_velocity)
	pass
