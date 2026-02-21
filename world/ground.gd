@tool
class_name Ground
extends StaticBody2D


@export var auto_generate = true  ## Automatically generate collision polygon from texture polygon.
@export var infinite = true  ##



func _enter_tree() -> void:
	if Engine.is_editor_hint():
		#set_notify_transform(true)
		EditorInterface.get_inspector().property_edited.connect( _on_property_edited )


func _exit_tree() -> void:
	if Engine.is_editor_hint():
		EditorInterface.get_inspector().property_edited.disconnect( _on_property_edited )



func _ready() -> void:
	if auto_generate == true:
		generate_poly_collision()
		#make_infinite()
		#generate_poly_collision()


func _on_property_edited(property: String):
	print(property)
	#if EditorInterface.get_inspector().get_edited_object() == self:
	if EditorInterface.get_inspector().get_edited_object() == $Polygon2D:
		match property:
			"polygon":
				print("polygon")
				pass


func generate_poly_collision():
	if !has_node("CollisionPolygon2D"):
		var polygon = CollisionPolygon2D.new()
		polygon.name = "CollisionPolygon2D"
		add_child(polygon)
		move_child(polygon, 0)

	if has_node("Polygon2D"):
		$CollisionPolygon2D.polygon = $Polygon2D.polygon


func make_infinite():
	var texture_poly: PackedVector2Array = $Polygon2D.polygon.duplicate()
	#var collision_poly: PackedVector2Array = $CollisionPolygon2D.polygon

	#var max_vect: Vector2 = Vector2.ZERO
	#var max_vectors = []

	for i in texture_poly.size():
		texture_poly[i].x *= 10
	$Polygon2D.polygon = texture_poly
