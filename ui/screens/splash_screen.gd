extends Control



func _ready():
	if Game.splash:
		self.show()
		await _splash()
	else:
		#Events.game_ready.emit()
		#get_parent().get_node("MainMenu").show()
		self.hide()

	if Game.preloader:
		Events.game_loading_ended.connect( _on_game_loading_ended )
		Events.game_loading_started.emit()




func _on_game_loading_ended():
	var tween = get_tree().create_tween()
	tween.tween_property( $LoadingLabel, "modulate:a", 0, 1.0 )
	tween.tween_interval( 0.25 )
	tween.tween_property( $FadeColor, "modulate:a", 0, 0.5 ).set_trans(Tween.TRANS_EXPO)
	#Events.game_ready.emit()
	await tween.finished
	self.hide()


func _splash():
	var tween = get_tree().create_tween()
	$TextureRect.modulate.a = 0
	$LoadingLabel.modulate.a = 0

	#tween.tween_interval( 1.0 )
	#tween.tween_property( $TextureRect, "modulate:a", 1, 2.0)
	#tween.tween_interval( 1.0 )
	#tween.tween_property( $TextureRect, "modulate:a", 0, 2.0)
	#tween.tween_interval( 1.0 )
	tween.tween_property( $LoadingLabel, "modulate:a", 1, 2.0 )
	#tween.tween_callback( Events.game_loading.emit )
	#tween.tween_property( $LoadingLabel, "modulate:a", 0, 2.0 )

	await tween.finished
