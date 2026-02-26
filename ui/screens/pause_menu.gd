extends PanelContainer


func _ready() -> void:
	Events.level_paused.connect( _on_level_paused )
	Events.level_unpaused.connect( _on_level_unpaused )

	%ExitButton.pressed.connect( func():
		Events.level_unpause_request.emit()
		Game.home()
		self.hide()
		pass )
	%RetryButton.pressed.connect( func():
		Events.level_unpause_request.emit()
		Game.retry_level()
		self.hide()
		pass )
	%ResumeButton.pressed.connect( func():
		Events.level_unpause_request.emit()
		self.hide()
		pass )


func _on_level_paused(level: Level):
	%ScoreDisplay.set_score(level.score)
	self.show()


func _on_level_unpaused(_level: Level):
	self.hide()
