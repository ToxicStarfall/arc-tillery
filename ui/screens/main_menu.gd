extends Control


@onready var UI = get_parent()


var exit_confirmed = false
var reset_confirmed = false


func _ready() -> void:
	self.show()
	%VersionLabel.text = "v" + ProjectSettings.get_setting("application/config/version")
	#ProjectSettings
	%PlayButton.pressed.connect( func():
		#self.hide()
		get_parent().get_node("LevelSelect").show()

		%ExitButton.text = "Exit"
		exit_confirmed = false
		%ResetButton.text = "RESET"
		reset_confirmed = false

		if Game.save_data.config.get_value("", "instructions") == false:
			UI.get_node("%Instructions").show()
		else:
			UI.get_node("%Instructions").hide()
	)

	%ExitButton.pressed.connect( func():
		if exit_confirmed:
			get_tree().quit()
		else:
			%ExitButton.text = "Exit Now? (1s)"
			%ResetButton.disabled = true
			await get_tree().create_timer(1.0).timeout
			%ExitButton.text = "Exit Now?"
			%ExitButton.disabled = false
			exit_confirmed = true
	)

	%ResetButton.pressed.connect( func():
		if reset_confirmed:
			%ResetButton.text = "SAVE RESET."
			reset_confirmed = false
			Game.save_data.config.clear()
			Game.save_data.save()
			Game.save_data.load_data()
			Events.game_reset.emit()

			await get_tree().create_timer(3.0).timeout
			%ResetButton.text = "RESET"
		else:
			%ResetButton.disabled = true
			%ResetButton.text = "RESET (3s)"
			await get_tree().create_timer(1.0).timeout
			%ResetButton.text = "RESET (2s)"
			await get_tree().create_timer(1.0).timeout
			%ResetButton.text = "RESET (1s)"
			await get_tree().create_timer(1.0).timeout
			%ResetButton.text = "ARE YOU SURE ?"
			%ResetButton.disabled = false
			reset_confirmed = true
	)
