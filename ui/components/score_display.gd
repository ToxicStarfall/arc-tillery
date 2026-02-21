extends HBoxContainer


const STAR_TEXTURE = preload("res://ui/icons/star.svg")
const STAR_EMPTY_TEXTURE = preload("res://ui/icons/star_empty.svg")



func set_score(score):
	for StarPlaceholder in self.get_children():
		if StarPlaceholder.get_index() <= score - 1:
			StarPlaceholder.texture = STAR_TEXTURE
		else:
			StarPlaceholder.texture = STAR_EMPTY_TEXTURE

	#if Text:
		#%ScoreLabel.text = "%s/%s" % [new_score, Game.current_level.max_score]

	pass
