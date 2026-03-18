extends PanelContainer


func _ready() -> void:
	Events.level_completed.connect( _on_level_completed )

	%BackButton.pressed.connect( func():
		Game.home()
		self.hide()
		pass )
	%RetryButton.pressed.connect( func():
		Game.retry_level()
		self.hide()
		pass )
	%NextButton.pressed.connect( func():
		Game.next_level()
		self.hide()
		pass )


func _on_level_completed(level: Level):
	if level.score > 0:
		%ResultLabel.text = "LEVEL SUCCESS"
		%WinAudio.play()
	else:
		%ResultLabel.text = "LEVEL FAILURE"
		%LoseAudio.play()
