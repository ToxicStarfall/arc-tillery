class_name Level
extends Node2D


@export var max_ammo := 3
@export var max_score := 1
var ammo = 3
var score := 0
var attempts := 0
#@export_file_path(".tscn") var ammo_type = 0

var unlimited_ammo = false


func _ready() -> void:
	setup()


func setup():
	Events.weapon_fired.connect( _on_weapon_fired )
	pass


func _on_weapon_fired():
	ammo -= 1
	pass
