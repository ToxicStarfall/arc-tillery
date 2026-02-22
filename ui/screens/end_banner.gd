extends PanelContainer


func _ready() -> void:
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
