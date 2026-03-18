class_name Star
extends Collectable


@export var score_amount: int = 1


func _collected():
	collected.emit()
	Game.current_level.add_score(score_amount)

	set_deferred("monitoring", false)  # Disable collision detection.
	$StarPickupParticles.emitting = true
	$Sprite2D.hide()
	$AudioStreamPlayer2D.play()

	await $StarPickupParticles.finished
	self.hide()
