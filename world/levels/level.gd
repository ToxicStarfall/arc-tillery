class_name Level
extends Node2D



@warning_ignore_start("unused_signal")
signal ammo_changed
signal score_changed
signal attempts_changed

signal star_collected


@export var max_ammo := 3
@export var max_score := 3
var ammo = 3
var score := 0
var attempts := 0

@export var active_weapon: Weapon
var available_weapons: Array[Weapon]

#@export var allowed_ammo_types


func _ready() -> void:
	setup()


func _on_child_entered_tree(node: Node):
	pass


func setup():
	Events.weapon_fired.connect( _on_weapon_fired )

	#Events.ammo_changed.emit( max_ammo )  # Initialize UI to starting ammo value


func _on_weapon_fired(_projectile):
	ammo = max(ammo - 1, 0)
	Events.ammo_changed.emit( ammo )


#func _on_score_incremented(increment_amount: int):
func add_score(score_amount: int):
	score = min(score + score_amount, max_score)
	Events.score_changed.emit( score )
