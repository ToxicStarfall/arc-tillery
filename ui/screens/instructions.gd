extends Control


func _ready() -> void:
	%BackButton.pressed.connect( func(): get_parent().hide() )
	%ContinueButton.pressed.connect( func(): self.hide() )
