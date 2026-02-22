extends Control



func _ready() -> void:
	_init_weapon_controls()
	_init_display()
	_init_misc()


func _init_weapon_controls():
	%AngleSpinBox.value_changed.connect( request_weapon_angle_change )
	%AngleSlider.value_changed.connect( request_weapon_angle_change )
	%GunpowderSpinBox.value_changed.connect( request_weapon_power_change )
	%GunpowderSlider.value_changed.connect( request_weapon_power_change )
	%FireButton.pressed.connect( request_weapon_fire )


func _init_display():
	Events.weapon_angle_changed.connect( _on_weapon_angle_changed )
	Events.weapon_power_changed.connect( _on_weapon_power_changed )

	Events.level_ammo_changed.connect( _on_level_ammo_changed )
	Events.level_score_changed.connect( _on_level_score_changed )


func _init_misc():
	Events.level_started.connect( _on_level_started )

	#%WinBanner/%BackButton.pressed.connect( func():
		#%WinBanner.hide()
		#Game.home()
		#self.hide()
		#pass )
	#%WinBanner/%RetryButton.pressed.connect( func():
		#%WinBanner.hide()
		#Game.retry_level()
		#pass )
	#%WinBanner/%NextButton.pressed.connect( func():
		#%WinBanner.hide()
		#Game.next_level()
		#pass )
	pass


func request_weapon_angle_change(value):
	Events.weapon_angle_change_requested.emit(value)


func request_weapon_power_change(value):
	value = max(value, 10.0)  # Limit value to minimum of 10.0
	Events.weapon_power_change_requested.emit(value)


func request_weapon_fire():
	Events.weapon_fire_requested.emit()



#region - - Updater Functions - - - #

func _on_level_started(_level: Level):
	self.show()


#func _on_level_completed(level: Level):
	#%WinBanner.show()
	#update_score_display(level.score, %WinBanner/%ScoreDisplay, %WinBanner/%ScoreLabel)


func _on_level_score_changed( new_score: int ):
	update_score_display(new_score, %ScoreDisplay, %ScoreLabel)
	%ScoreLabel.text = "%s/%s" % [new_score, Game.current_level.max_score]


func _on_level_ammo_changed( new_ammo_count: int ):
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


#endregion - - - - - #


func update_score_display(new_score: int, Display: Container, Text: Control = null):
	for StarPlaceholder in Display.get_children():
		if StarPlaceholder.get_index() <= Game.current_level.score - 1:
			StarPlaceholder.texture = preload("res://ui/icons/star.svg")
		else:
			StarPlaceholder.texture = preload("res://ui/icons/star_empty.svg")

	if Text:
		%ScoreLabel.text = "%s/%s" % [new_score, Game.current_level.max_score]
