class_name Star
extends Collectable


@export var score_amount: int = 1


func _collected():
	print("collected")
	#Events.score_incremented.emit(score_amount)
	Game.current_level.add_score(score_amount)
	pass
