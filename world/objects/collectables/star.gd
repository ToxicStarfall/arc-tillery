class_name Star
extends Collectable


@export var score_amount: int = 1


func _collected():
	Game.current_level.add_score(score_amount)
	set_deferred("monitoring", false)
	self.hide()
