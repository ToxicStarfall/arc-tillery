extends Control



func _ready() -> void:
	_init_weapon_controls()
	_init_weapon_display()
	pass


func _init_weapon_controls():
	%AngleSpinBox.value_changed.connect( request_weapon_angle_change )
	%AngleSlider.value_changed.connect( request_weapon_angle_change )
	%GunpowderSpinBox.value_changed.connect( request_weapon_power_change )
	%GunpowderSlider.value_changed.connect( request_weapon_power_change )
	%FireButton.pressed.connect( request_weapon_fire )


func _init_weapon_display():
	Events.weapon_angle_changed.connect( _on_weapon_angle_changed )
	Events.weapon_power_changed.connect( _on_weapon_power_changed )
	pass


func request_weapon_angle_change(value):
	Events.weapon_angle_change_requested.emit(value)
	#%AngleLabel.text = str(value) + "°"
	#%AngleSpinBox.value = value
	#%AngleSlider.value = value
	#Game.current_weapon.current_angle = value


func request_weapon_power_change(value):
	value = max(value, 10.0)  # Limit value to minimum of 10.0
	Events.weapon_power_change_requested.emit(value)
	#%GunpowderLabel.text = str(value) + "%"
	#%GunpowderSpinBox.value = value
	#%GunpowderSlider.value = value
	#Game.current_weapon.power = value


func request_weapon_fire():
	Events.weapon_fire_requested.emit()


func _on_weapon_angle_changed( value ):
	%AngleSpinBox.value = value
	%AngleSlider.value = value

func _on_weapon_power_changed( value ):
	%GunpowderSpinBox.value = value
	%GunpowderSlider.value = value
