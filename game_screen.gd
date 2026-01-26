extends Control



func _ready() -> void:
	_init_weapon_controls()
	_init_weapon_display()
	pass


func _init_weapon_controls():
	%AngleSlider.value_changed.connect( func(value):
		%AngleLabel.text = str(value) + "°"
		%AngleSpinBox.value = value
		Game.current_weapon.current_angle = value
		Events.weapon_angle_changed.emit(value)
	)

	%GunpowderSlider.value_changed.connect( func(value):
		value = max(value, 10.0)
		%GunpowderSlider.value = value
		%GunpowderLabel.text = str(value) + "%"
		%GunpowderSpinBox.value = value
		Game.current_weapon.power_level = value)

	%FireButton.pressed.connect( func():

		pass
	)
	pass


func _init_weapon_display():
	pass


func sync_control():
	pass
