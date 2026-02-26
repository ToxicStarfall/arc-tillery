@tool
extends HBoxContainer


const STAR_TEXTURE = preload("res://ui/icons/star.svg")
const STAR_EMPTY_TEXTURE = preload("res://ui/icons/star_empty.svg")

## @tool to provide instant textuer size update to all placeholders
@export var star_size: Vector2 = Vector2(32, 32):
	set(size):
		star_size = size
		for placeholder in self.get_children():
			placeholder.custom_minimum_size = size


func set_score(score):
	for StarPlaceholder in self.get_children():
		if StarPlaceholder.get_index() <= score - 1:
			StarPlaceholder.texture = STAR_TEXTURE
		else:
			StarPlaceholder.texture = STAR_EMPTY_TEXTURE

	#if Text:
		#%ScoreLabel.text = "%s/%s" % [new_score, Game.current_level.max_score]

	pass
