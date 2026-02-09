class_name Ground
extends StaticBody2D



@export var auto_generate = true  ## Automatically generate collision polygon from texture polygon.
@export var infinite = true  ##


func _ready() -> void:
	if auto_generate == true:
		generate_poly_collision()
		make_infinite()


func generate_poly_collision():
	if !has_node("CollisionPolygon2D"):
		var polygon = CollisionPolygon2D.new()
		polygon.name = "CollisionPolygon2D"
		add_child(polygon)
		move_child(polygon, 0)


	if has_node("Polygon2D"):
		$CollisionPolygon2D.polygon = $Polygon2D.polygon


func make_infinite():
	var max_vec: Vector2 = Vector2.ZERO
	#for i in $CollisionPolygon2D.polygon.size():
	for vec2 in $CollisionPolygon2D.polygon:
		if vec2.x >= max_vec.x:
			max_vec = vec2
	#$CollisionPolygon2D.polygon.get()
