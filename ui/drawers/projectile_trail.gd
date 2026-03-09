extends Node2D


var projectiles: Array[Projectile] = []

var enabled: bool = true

var level: Level


func _ready() -> void:
	Events.level_ended.connect( _on_level_ended )
	Events.weapon_fired.connect( _on_weapon_fired )
	pass


func _physics_process(_delta: float) -> void:
	for i in projectiles.size():
		if !projectiles[i].sleeping:
			var a = get_child(i).points.duplicate()
			a.append( projectiles[i].position )
			get_child(i).points = a
		pass


func _on_weapon_fired(projectile: Projectile):
	for i in projectiles:  # Gray out all prior projectile trails.
		get_node(str(i.get_rid())).default_color = Color.GRAY

	projectiles.append( projectile )

	var projectile_trail = Line2D.new()
	projectile_trail.name = str(projectile.get_rid())
	projectile_trail.width = 5
	projectile_trail.joint_mode = Line2D.LINE_JOINT_ROUND
	projectile_trail.begin_cap_mode = Line2D.LINE_JOINT_ROUND
	projectile_trail.end_cap_mode = Line2D.LINE_JOINT_ROUND
	self.add_child( projectile_trail )


func _on_level_ended(_level):
	for child in get_children():
		child.queue_free()
	projectiles.clear()


#func _draw():
	#if level:
		#if enabled:
			#_draw_pointers()


func _draw_pointers():
	#var color := Color.WHITE
	#var width = -1  # Width (-1 = Autoscale)
	#var antialiased = false

	#if level.tracked_projectile:
	#points.append( level.tracked_projectile.position )

	#if points.size() % 2 == 0:
		#for point in points:
			#draw_multiline(points, color, width, antialiased)
			#draw_polyline(points, color, width, antialiased)
		#if points.size() > 1:
			#draw_arc()
			#draw_line(points[-2], points[-1], color, width, antialiased)
	pass
