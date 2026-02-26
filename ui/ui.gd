extends Node


#var last_

var SCREENS = {

}



func _ready() -> void:
	Events.level_started.connect( _on_level_started )
	Events.level_completed.connect( _on_level_completed )
	#Events.level_paused.connect( _on_level_paused )
	#Events.level_unpaused.connect( _on_level_unpaused )

	%MainMenu/%PlayButton.pressed.connect( func(): %LevelSelect.show() )

	%GameScreen.hide()



func _on_level_started(_level: Level):
	%MainMenu.hide()
	%LevelSelect.hide()


func _on_level_completed(level: Level):
	%EndBanner.show()
	%EndBanner.get_node("%ScoreDisplay").set_score( level.score )
	#update_score_display(level.score, %WinBanner/%ScoreDisplay, %WinBanner/%ScoreLabel)


#func _on_level_paused(_level: Level):
	#%PauseMenu.show()
#
#func _on_level_unpaused(_level: Level):
	#%PauseMenu.hide()


#func navigate_to(screen: Control):
	#pass
