@tool
class_name Ground
extends StaticBody2D


@export_tool_button("Generate Collisions") var generate_collision = generate_poly_collision
@export var auto_generate = true  ## Automatically generate collision polygon from texture polygon.
@export var infinite = true  ##



func _enter_tree() -> void:
	if Engine.is_editor_hint():
		#set_notify_transform(true)
		EditorInterface.get_inspector().property_edited.connect( _on_property_edited )


func _exit_tree() -> void:
	if Engine.is_editor_hint():
		EditorInterface.get_inspector().property_edited.disconnect( _on_property_edited )


## @tool function
func _on_property_edited(property: String):
	if Engine.is_editor_hint():

		print(property)
		#if EditorInterface.get_inspector().get_edited_object() == self:
		#if EditorInterface.get_inspector().get_edited_object() == $Polygon2D:
		if Engine.get_singleton("EditorInterface").get_inspector().get_edited_object() == $Polygon2D:
			match property:
				"polygon":
					print("polygon")
					pass


func _ready() -> void:
	if auto_generate == true:
		generate_poly_collision()
		#make_infinite()
		#generate_poly_collision()


func generate_poly_collision():
	if !has_node("CollisionPolygon2D"):
		var polygon = CollisionPolygon2D.new()
		polygon.name = "CollisionPolygon2D"
		add_child(polygon)
		move_child(polygon, 0)

		if Engine.is_editor_hint():  # Show the polygon in scene tree while in editor
			polygon.owner = get_tree().edited_scene_root

	if has_node("Polygon2D"):
		$CollisionPolygon2D.polygon = $Polygon2D.polygon


func make_infinite():
	var texture_poly: PackedVector2Array = $Polygon2D.polygon.duplicate()
	#var collision_poly: PackedVector2Array = $CollisionPolygon2D.polygon

	#var max_vect: Vector2 = Vector2.ZERO
	#var max_vectors = []
	var vectors = []

	for i in texture_poly.size():
		vectors.append( texture_poly[i] )
		#texture_poly[i].x *= 10
	vectors.sort()

	for vector in vectors.slice(0, 2) + vectors.slice(-3, -1):
		texture_poly[ texture_poly.find(vector) ].x *= 10
		#vector.x *= 10
	#print(vectors)
	$Polygon2D.polygon = texture_poly
