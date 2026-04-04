extends Control


func _ready() -> void:
	#%BackButton.pressed.connect( func(): get_parent().hide() )
	%ContinueButton.pressed.connect( func():
		Game.save_data.config.set_value("", "instructions", true)
		Game.save_data.save()
		self.hide()
		)
