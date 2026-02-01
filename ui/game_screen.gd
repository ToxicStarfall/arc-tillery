extends Control



func _ready() -> void:
	_init_weapon_controls()
	_init_display()


func _init_weapon_controls():
	%AngleSpinBox.value_changed.connect( request_weapon_angle_change )
	%AngleSlider.value_changed.connect( request_weapon_angle_change )
	%GunpowderSpinBox.value_changed.connect( request_weapon_power_change )
	%GunpowderSlider.value_changed.connect( request_weapon_power_change )
	%FireButton.pressed.connect( request_weapon_fire )


func _init_display():
	Events.ammo_changed.connect( _on_ammo_changed )
	Events.weapon_angle_changed.connect( _on_weapon_angle_changed )
	Events.weapon_power_changed.connect( _on_weapon_power_changed )

	Events.score_changed.connect( _on_score_changed )



func request_weapon_angle_change(value):
	Events.weapon_angle_change_requested.emit(value)


func request_weapon_power_change(value):
	value = max(value, 10.0)  # Limit value to minimum of 10.0
	Events.weapon_power_change_requested.emit(value)


func request_weapon_fire():
	Events.weapon_fire_requested.emit()



#region - - Updater Functions - - - #

func _on_ammo_changed( new_ammo_count: int ):
	#print("Ammo display update")
	var AmmoIcons = %AmmoDisplay/MarginContainer/HBoxContainer/HBoxContainer
	for Icon in AmmoIcons.get_children():
		if Icon.get_index() <= new_ammo_count - 1:
			Icon.texture = preload("res://ui/icons/ammo.svg")
		else:
			Icon.texture = preload("res://ui/icons/ammo_empty.svg")
	%AmmoLabel.text = "%s/%s" % [new_ammo_count, Game.current_level.max_ammo]


func _on_weapon_angle_changed( value ):
	%AngleSpinBox.value = value
	%AngleSlider.value = value


func _on_weapon_power_changed( value ):
	%GunpowderSpinBox.value = value
	%GunpowderSlider.value = value



func _on_score_changed( new_score: int ):
	var ScoreIcons = $ScoreDisplay/MarginContainer/VBoxContainer/HBoxContainer
	for Icon in ScoreIcons.get_children():
		if Icon.get_index() <= new_score - 1:
			Icon.texture = preload("res://ui/icons/star.svg")
		else:
			Icon.texture = preload("res://ui/icons/star_empty.svg")
	%ScoreLabel.text = "%s/%s" % [new_score, Game.current_level.max_score]
	pass

#endregion - - - - - #
