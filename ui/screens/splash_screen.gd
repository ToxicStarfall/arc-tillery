extends Control



func _ready():
	Events.game_loading_ended.connect( _on_game_loading_ended )

	await splash()
	Events.game_loading_started.emit()


func _on_game_loading_ended():
	var tween = get_tree().create_tween()
	tween.tween_property( $LoadingLabel, "modulate:a", 0, 1.0 )
	tween.tween_interval( 0.5 )
	tween.tween_property( $FadeColor, "modulate:a", 0, 0.5 ).set_ease(Tween.EASE_IN)
	Events.game_ready.emit()
	self.hide()


func splash():
	var tween = get_tree().create_tween()
	$TextureRect.modulate.a = 0
	$LoadingLabel.modulate.a = 0

	tween.tween_interval( 1.0 )
	tween.tween_property( $TextureRect, "modulate:a", 1, 2.0)
	tween.tween_interval( 1.0 )
	tween.tween_property( $TextureRect, "modulate:a", 0, 2.0)
	tween.tween_interval( 1.0 )
	tween.tween_property( $LoadingLabel, "modulate:a", 1, 2.0 )
	#tween.tween_callback( Events.game_loading.emit )
	#tween.tween_property( $LoadingLabel, "modulate:a", 0, 2.0 )

	await tween.finished
