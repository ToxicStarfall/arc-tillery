extends Node


#var last_

var SCREENS = {

}



func _ready() -> void:
	#Events.game_ready.connect( _on_game_ready )
	Events.level_started.connect( _on_level_started )
	Events.level_completed.connect( _on_level_completed )
	Events.level_ended.connect( _on_level_ended )

	%GameScreen.hide()


#func _on_game_ready():
	#%MainMenu.show()


func _on_level_started(_level: Level):
	%MainMenu.hide()
	%LevelSelect.hide()
	%GameScreen.show()


func _on_level_completed(level: Level):
	%EndBanner.show()
	%EndBanner.get_node("%ScoreDisplay").set_score( level.score )
	#update_score_display(level.score, %WinBanner/%ScoreDisplay, %WinBanner/%ScoreLabel)


func _on_level_ended(_level: Level):
	%MainMenu.show()
	%LevelSelect.show()
	%LevelSelect.refresh()
	%GameScreen.hide()
	pass


#func navigate_to(screen: Control):
	#pass
