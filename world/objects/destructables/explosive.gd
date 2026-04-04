extends DestructableObject2



@export var area = 512.0
@export var min_damage = 100.0
@export var max_damage = 0
var objects = []
var destroyed = false


func _ready():
	super()
	#body_entered.connect( _on_body_entered )
	body_exited.connect( _on_body_exited )
	$Area2D/CollisionShape2D.shape.radius = area


func _physics_process(_delta: float) -> void:
	if destroyed:
		#print(objects)
		destroyed = false
	pass


func _on_body_entered(body: Node):
	objects.append(body)

func _on_body_exited(body):
	objects.erase(body)


func _destroy():
	destroyed = true
	for obj in objects:
		if obj is not Ground:
			var dir = (obj.position - self.position).normalized()
			#print(dir)
			obj.apply_impulse(dir * 10000.0)
			#obj.apply_impulse(Vector2.UP * 10000.0)
			#obj.position += dir * 1000
	pass
