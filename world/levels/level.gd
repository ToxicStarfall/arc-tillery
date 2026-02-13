class_name Level
extends Node2D


@warning_ignore_start("unused_signal")
signal ammo_changed
signal score_changed
signal attempts_changed

signal star_collected



@export var max_ammo := 3
@export var max_score := 3
var ammo := 3
var score := 0
var attempts := 0

#@export var starting_weapon: Weapon
@export var current_weapon: Weapon
var available_weapons: Array[Weapon]

@export var current_projectile: Projectile

#@export var allowed_ammo_types


#@onready var Camera: Camera2D = Camera2D.new()
#@onready
var Camera: Camera2D# = $Camera2D



func _ready() -> void:
	setup()


func setup():
	Events.level_score_changed.emit( score )  # Initialize UI to starting score value
	Events.level_ammo_changed.emit( max_ammo )  # Initialize UI to starting ammo value
	Events.weapon_fired.connect( _on_weapon_fired )

	Camera = $Camera2D
	Camera.reparent(current_weapon)
	Camera.position = Vector2.ZERO


func end():
	Events.level_ended.emit(self)



func _on_weapon_fired(projectile):
	self.add_child(projectile)
	#current_projectile = projectile
	if current_projectile: current_projectile.sleeping_state_changed.disconnect( _on_projectile_sleeping )
	current_projectile = projectile
	current_projectile.sleeping_state_changed.connect( _on_projectile_sleeping.bind(current_projectile) )

	Camera.reparent(current_projectile)
	Camera.position = Vector2.ZERO  # Re-center camera onto projectile
	Camera.offset = Vector2.ZERO

	ammo = max(ammo - 1, 0)
	Events.level_ammo_changed.emit( ammo )

	if ammo == 0:
		Events.level_completed.emit(self)


func _on_projectile_sleeping(projectile):
	if projectile.sleeping:
		camera_focus_weapon()



func add_score(score_amount: int):
	score = min(score + score_amount, max_score)
	Events.level_score_changed.emit( score )

	if score == max_score:
		Events.level_completed.emit(self)


func camera_focus_weapon():
	#Camera.position_smoothing_enabled = false
	#Camera.reparent(current_weapon, true)
	Camera.reparent(current_weapon)
	#Camera.position = projectile.global_position

	var tween = get_tree().create_tween()
	tween.tween_property(Camera, "position", Vector2.ZERO, 3)
	await tween.finished



func get_level_id() -> String:
	return scene_file_path.split("/")[-1].split(".")[0]
