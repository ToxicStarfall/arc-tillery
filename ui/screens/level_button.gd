extends PanelContainer


@warning_ignore_start("unused_signal")
signal pressed


var text: String:
	set(text):
		%Label.text = text

var score: int:
	set(score):
		%ScoreDisplay.set_score( score )



func _ready() -> void:
	%Button.pressed.connect( pressed.emit )
	pass
