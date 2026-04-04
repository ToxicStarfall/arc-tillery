class_name Level
extends Node2D


@warning_ignore_start("unused_signal")
signal ammo_changed
signal score_changed
signal attempts_changed

signal star_collected


@export var level_name := "Level Name"
@export var max_ammo := 3
@export var max_score := 3
var ammo := 3
var score := 0
#var elapsed_time := 0.0

#var attempts := 0
var high_score := 0
#var total_time := 0.0
#var unlocked := false

@export var current_weapon: Weapon
#@export var starting_weapon: Weapon
#@export var allowed_ammo_types

var active_projectiles: Array[Projectile] = []
var tracked_projectile: Projectile

var camera_tracked_node: Node
var camera_locked: bool = true
var camera_pan_velocity: Vector2

#var weapons: Array[Weapon] = []
var stars: Array[Star] = []

var paused := false
var completed := false

var Camera: Camera2D
var Drawers: CanvasLayer



func _init() -> void:
	child_entered_tree.connect( _on_child_entered_tree )


func _ready() -> void:
	_setup()


func _setup():
	# UI Request Signals
	Events.level_pause_request.connect( pause )
	Events.level_unpause_request.connect( unpause )
	# Updater Signals
	Events.level_score_changed.emit( score )  # Initialize UI to starting score value
	Events.level_ammo_changed.emit( max_ammo )  # Initialize UI to starting ammo value
	Events.camera_lock_changed.connect( _on_camera_lock_changed )
	Events.weapon_fired.connect( _on_weapon_fired )

	_setup_camera()
	Drawers = Game.Drawers
	for drawer in Drawers.get_drawers(): drawer.level = self  # Set the "level" var in each drawer.



# Initialize Camera into the level.
func _setup_camera():
	if !has_node("Camera2D"):
		Camera = preload("res://world/camera_2d.tscn").instantiate()
		add_child(Camera)
	else: Camera = $Camera2D

	Camera.reparent(current_weapon)
	Camera.position = Vector2.ZERO
	_setup_camera_limits()


# Set camera limit to disable tracking past certain areas.
func _setup_camera_limits():
	const _TOP_LIMIT = 2000
	const BOTTOM_LIMIT = 1000
	const HORIZONTAL_LIMIT = 2000
	var objects = get_objects()
	var x = []
	var y = []
	for obj in objects:
		x.append(obj.position.x)
		y.append(obj.position.y)
	x.sort()
	y.sort()
	Camera.limit_left = x[1] - HORIZONTAL_LIMIT
	Camera.limit_right = x[-1] + HORIZONTAL_LIMIT
	#Camera.limit_top = y[1] - TOP_LIMIT
	Camera.limit_bottom = y[-1] + BOTTOM_LIMIT
	Camera.limit_smoothed = true

	var bounds = Area2D.new()
	bounds.name = "LevelBounds"
	bounds.collision_layer = 0  # Not detectable by other objects.
	bounds.collision_mask = 4  # Detects projectiles only.
	bounds.body_entered.connect( _on_body_exit_bounds )
	var collision_left := CollisionShape2D.new()
	var collision_right := CollisionShape2D.new()
	var collision_top := CollisionShape2D.new()
	var collision_bottom := CollisionShape2D.new()
	var bounds_collisions = [collision_left, collision_right, collision_top, collision_bottom]
	collision_left.position = Vector2(Camera.limit_left, 0)
	collision_right.position = Vector2(Camera.limit_right, 0)
	collision_top.position = Vector2(0, Camera.limit_top)
	collision_bottom.position = Vector2(0, Camera.limit_bottom)
	for collision in bounds_collisions:
		collision.shape = WorldBoundaryShape2D.new()
		collision.shape.normal = (Vector2.ZERO - collision.position).normalized()
		bounds.add_child(collision)
	self.add_child(bounds)


func _on_child_entered_tree(child: Node):
	if child is Star:
		var star = child
		stars.append(star)
		star.collected.connect( _on_star_collected )


# Notifies that the Level has started.
func start():
	Drawers.queue_redraw()
	Events.level_started.emit(self)

# Notifies that the Level is completed but is NOT ready to be cleared.
func complete():
	if !completed:
		completed = true
		Events.level_completed.emit(self)

# Notifies that the Level has ended and is ready to be cleared.
func end():
	Events.level_ended.emit(self)


func pause():
	get_tree().paused = true
	paused = true
	Events.level_paused.emit(self)


func unpause():
	get_tree().paused = false
	paused = false
	Events.level_unpaused.emit(self)


func _unhandled_input(event: InputEvent) -> void:
	# NOTE: event.factor is used for variable inputs such as trackpad scroll speed
	var zoom_factor = 0.1
	if event is InputEventMouseButton and !event.factor == 1:
		#zoom_factor = event.factor
		zoom_factor = 0.01
		#print(zoom_factor)

	if event.is_action_pressed("zoom_in"):
		Camera.zoom = (Camera.zoom + (Vector2.ONE * zoom_factor)).minf(1.5)
		Drawers.queue_redraw()
	if event.is_action_pressed("zoom_out"):
		Camera.zoom = (Camera.zoom - (Vector2.ONE * zoom_factor)).maxf(0.1)
		Drawers.queue_redraw()
	if event.is_action_pressed("restart"):
		Game.retry_level()

	if !camera_locked:
		var pan_x = Input.get_axis("camera_pan_left", "camera_pan_right")
		var pan_y = Input.get_axis("camera_pan_up", "camera_pan_down")
		camera_pan_velocity = Vector2(pan_x, pan_y).normalized() * (512 + 256)


func _physics_process(delta: float) -> void:
	if !camera_locked:
		Camera.position += camera_pan_velocity * delta


func _on_camera_lock_changed():
	get_viewport().gui_release_focus()
	camera_locked = !camera_locked
	Camera.limit_enabled = camera_locked
	Camera.drag_horizontal_enabled = camera_locked
	Camera.drag_vertical_enabled = camera_locked

	if camera_locked:
		Camera.position = Vector2.ZERO
		Camera.position_smoothing_speed = 5.0
		#Camera.drag_top_margin = 0.2
		#Camera.drag_bottom_margin = 0.2
		#Camera.drag_left_margin = 0.2
		#Camera.drag_right_margin = 0.2
	else:
		Camera.position_smoothing_speed = 10.0
		#Camera.drag_top_margin = 0.05
		#Camera.drag_bottom_margin = 0.05
		#Camera.drag_left_margin = 0.05
		#Camera.drag_right_margin = 0.05


func _on_weapon_fired(projectile: Projectile):
	if ammo > 0:
		self.add_child(projectile)
		#if tracked_projectile:  # Disconnect previous tracked projectile.
			#tracked_projectile.sleeping_state_changed.disconnect( _on_projectile_sleeping )
		active_projectiles.append(projectile)
		tracked_projectile = projectile
		tracked_projectile.sleeping_state_changed.connect( _on_projectile_sleeping_state_changed.bind(tracked_projectile) )
		#is_tracking_projectile = true

		Camera.reparent(tracked_projectile)
		Camera.position = Vector2.ZERO  # Re-center camera onto projectile
		#Camera.offset = Vector2.ZERO

		ammo = max(ammo - 1, 0)
		Events.level_ammo_changed.emit( ammo )


# When projectile physics stops running (idle).
func _on_projectile_sleeping_state_changed(projectile):
	if projectile.sleeping:
		active_projectiles.erase(projectile)
		#await get_tree().create_timer(3.0).timeout
		if projectile.sleeping:  # Check again after 3 seconds.
			camera_focus_weapon()
			check_level_completion()
	else:
		active_projectiles.append(projectile)


# When projectile goes past focused play area.
func _on_body_exit_bounds(body: PhysicsBody2D):
	if body is Projectile:
		# Disconnect to prevent refiring checks.
		active_projectiles.erase(body)
		body.sleeping_state_changed.disconnect( _on_projectile_sleeping_state_changed )

		await get_tree().create_timer(3.0).timeout
		camera_focus_weapon()
		check_level_completion()


func _on_star_collected():
	Drawers.queue_redraw()  # Refresh Star pointers

	await get_tree().create_timer(3.0).timeout
	camera_focus_weapon()
	# Hard check after a star is collected
	if score == max_score or ammo == 0:
		complete()
	#check_level_completion()


func check_level_completion():
	if active_projectiles.is_empty() and (ammo == 0 or score == max_score):
	#if ammo == 0 or score == max_score:
		complete()


func add_score(score_amount: int):
	score = min(score + score_amount, max_score)
	Events.level_score_changed.emit( score )



func camera_focus_node(node: Node, time: float = 0.0):
	Camera.reparent(node)
	#is_tracking_projectile = false
	#Camera.position_smoothing_enabled = false
	#Camera.position = projectile.global_position

	var tween = get_tree().create_tween()
	tween.tween_property(Camera, "position", Vector2.ZERO, time)
	await tween.finished


func camera_focus_weapon():
	#Camera.position_smoothing_enabled = false
	#Camera.position = projectile.global_position
	Camera.reparent(current_weapon)
	#is_tracking_projectile = false

	var tween = get_tree().create_tween()
	tween.tween_property(Camera, "position", Vector2.ZERO, 3)
	await tween.finished


# Returns an array of (non-Ground) world objects.
func get_objects(_include_ground: bool = false) -> Array:
	var objects = []
	for child in get_children():
		#if include_ground == true:
		if child is Weapon or child is Collectable or child is Interactable or child is DestructableObject2:
				objects.append(child)
	return objects


# Returns distance between "from" and "to" as Vector2.
func get_distance(from: Node2D, to: Node2D) -> Vector2:
	var distance = (to.global_position - from.global_position) / Game.PIXELS_PER_METER
	return distance


func get_level_id() -> String:
	return scene_file_path.get_file().get_slice(".", 0)

#func get_level_size() -> Vector2:
	#return Vector2(Camera.limit_left )


func get_save_data() -> Dictionary:
	var level_data = {}
	level_data.set("id", get_level_id())
	level_data.set("high_score", score)
	#level_data.set("time", total_time)
	return level_data
