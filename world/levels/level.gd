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
@export var active_weapon: Weapon
var available_weapons: Array[Weapon]

#@export var allowed_ammo_types

@onready var Camera: Camera2D = Camera2D.new()



func _ready() -> void:
	setup()


func setup():
	Events.level_score_changed.emit( score )  # Initialize UI to starting score value
	Events.level_ammo_changed.emit( max_ammo )  # Initialize UI to starting ammo value
	Events.weapon_fired.connect( _on_weapon_fired )


#func _on_child_entered_tree(node: Node):
	#pass

func start():
	pass


func end():
	Events.level_ended.emit(self)



func _on_weapon_fired(projectile):
	self.add_child(projectile)

	ammo = max(ammo - 1, 0)
	Events.level_ammo_changed.emit( ammo )

	if ammo == 0:
		Events.level_completed.emit(self)


func add_score(score_amount: int):
	score = min(score + score_amount, max_score)
	Events.level_score_changed.emit( score )

	if score == max_score:
		Events.level_completed.emit(self)


func get_level_id() -> String:
	return scene_file_path.split("/")[-1].split(".")[0]
