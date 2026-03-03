extends Node2D


var markers: bool = true
var pointers: bool = true

var level: Level


func _draw() -> void:
	const area = Vector2i(100, 1)  ## The 2D area to draw markers.
	var Camera: Camera2D = Game.Camera
	var weapon := Game.current_weapon
	if Camera and weapon:
		var interval = 2
		#print( Camera.position.y - (Camera.global_position.y / Camera.zoom.y) )
		#print( get_viewport().get_mouse_position() )
		if Camera.zoom.x > 1.0: interval = 1
		elif Camera.zoom.x > 0.6: interval = 2
		elif Camera.zoom.x > 0.2: interval = 5
		else: interval = 10
		#else: interval = 2

		for x in area.x:
			var start_pos := Vector2( weapon.global_position.x, weapon.global_position.y )
			var end_pos := Vector2( weapon.global_position.x,
				# Difference between camera y and top of viewport
				#Camera.position.y - (Camera.global_position.y / Camera.zoom.y) )
				weapon.global_position.y - 100)
			var text_pos := Camera.global_position + Vector2(8 / Camera.zoom.length(), 0)
			var offset: int =  x
			var line_color := Color(1, 1, 1, 0.75)
			var _text = true
			var scaler = Camera.zoom.length()

			if !(x % interval) == 0:
				end_pos += Vector2(0, 100)
				line_color.a = 0.4
				#text = false

			_draw_marker(start_pos, end_pos, text_pos, offset, line_color, scaler)


func _draw_marker(start: Vector2, end: Vector2, text_pos: Vector2, offset: int, color: Color, scaler):
	var distance := offset
	offset = offset * Game.PIXELS_PER_METER
	var offset_h := Vector2(offset, 0)

	#var scaler = Camera.zoom.length()

	var font: Font = ThemeDB.fallback_font  # Text font
	var text: String = str(distance)
	const alignment := HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT
	var text_position: Vector2  # Text position
	var text_color := Color.BLACK
	var font_size: int = 24 / scaler  # Font size (scales font up as you zoom out)
	const text_justification = 3  # Justification Flag - (KASHIDA + WORD_BOUND)  TextServer.JustificationFlag
	const text_direction := TextServer.Direction.DIRECTION_AUTO  # Text Server Direction
	const text_orientation := TextServer.ORIENTATION_HORIZONTAL  # Text Server Orientation

	# Draw measurement lines
	draw_line(start + offset_h, end + offset_h, color)

	if (distance % 2) == 0:
	# Draw measurements
	#if text:
		draw_string(
			font,
			text_position + offset_h,  # Text position
			"%sm" % [text],  # Text
			alignment,  # Alignment
			-1,  # Width
			font_size,  # Font size (scales font up as you zoom out)
			text_color,  # Text color
			text_justification,
			text_direction,
			text_orientation
			)
		#draw_string(
			#ThemeDB.fallback_font,  # Text font
			#text_pos + offset_h,  # Text position
			#"%sm" % [raw_offset],  # Text
			#HorizontalAlignment.HORIZONTAL_ALIGNMENT_LEFT,  # Alignment
			#-1,  # Width
			#24 / scaler,  # Font size (scales font up as you zoom out)
			#color,  # Text color
			#3,
			#TextServer.Direction.DIRECTION_AUTO,
				#TextServer.ORIENTATION_HORIZONTAL )
