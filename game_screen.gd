extends Control


func _ready() -> void:
	%AngleSlider.value_changed.connect( func(value):
		%AngleLabel.text = str(value) + "°"
		Game.current_weapon.current_angle = value)
	pass
