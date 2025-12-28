extends Control


func _ready() -> void:
	%AngleSlider.value_changed.connect( func(value):
		%AngleLabel.text = str(value) + "°"
		%AngleSpinBox.value = value
		Game.current_weapon.current_angle = value)

	%GunpowderSlider.value_changed.connect( func(value):
		value = max(value, 10.0)
		%GunpowderSlider.value = value
		%GunpowderLabel.text = str(value) + "%"
		%GunpowderSpinBox.value = value
		Game.current_weapon.power_level = value)
	pass


func sync_control():
	pass
