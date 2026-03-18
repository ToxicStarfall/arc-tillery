## A button which plays some audio when pressed
class_name AudioButton
extends Button


func _ready() -> void:
	pressed.connect( func():
		Game.UI.get_node("Sounds/ButtonPressed").play()
		)
