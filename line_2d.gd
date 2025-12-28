extends Line2D


func _draw() -> void:
	#print("redrawn")
	#print( Game.get_viewport().get_visible_rect().size.y )
	print( Game.get_viewport().get_visible_rect().get_support(Vector2.DOWN) )
	draw_line(
		points[0],
		Vector2(
			points[0].x,
			points[0].y - Game.get_viewport().get_visible_rect().size.y,
		),
		Color.WHITE)
