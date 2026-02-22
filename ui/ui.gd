extends Node


#var last_
var SCREENS = {

}



func _ready() -> void:
	Events.level_started.connect( _on_level_started )
	Events.level_completed.connect( _on_level_completed )

	%MainMenu/%PlayButton.pressed.connect( func(): %LevelSelect.show() )

	%GameScreen.hide()



func _on_level_started(_level: Level):
	%MainMenu.hide()
	%LevelSelect.hide()


func _on_level_completed(level: Level):
	%EndBanner.show()
	%EndBanner.get_node("%ScoreDisplay").set_score( level.score )
	#update_score_display(level.score, %WinBanner/%ScoreDisplay, %WinBanner/%ScoreLabel)


func navigate_to(screen: Control):
	pass
