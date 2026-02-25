extends Node2D


var enabled: bool = true

var level: Level


func _draw():
	if level:
		if enabled:
			_draw_pointers()


func _draw_pointers():
	var scaler = level.Camera.zoom.length()

	var font: Font = ThemeDB.fallback_font  # Text font
	var text: String = "STAR"
	const alignment := HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT
	var text_position: Vector2  # Text position
	var text_color := Color.BLACK
	var font_size: int = 24 / scaler  # Font size (scales font up as you zoom out)
	const text_justification = 3  # Justification Flag - (KASHIDA + WORD_BOUND)  TextServer.JustificationFlag
	const text_direction := TextServer.Direction.DIRECTION_AUTO  # Text Server Direction
	const text_orientation := TextServer.ORIENTATION_HORIZONTAL  # Text Server Orientation

	for star in level.stars:
		#text = str((level.current_weapon.global_position - star.global_position).length())
		text = str(level.get_distance(level.current_weapon, star).x)
		text_position = star.global_position
		text_position -= Vector2(32, 32)  # half the size of stars

		draw_string(
			font, text_position,
			#text_pos + offset_h,  # Text position
			"%sm" % [text],  # Text
			alignment,  # Alignment
			-1,  # Width
			font_size,  # Font size (scales font up as you zoom out)
			text_color,  # Text color
			text_justification,
			text_direction,
			text_orientation
			)
	pass
