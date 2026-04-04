@tool
## Plays a random audio stream out of the selecetd audio streams.
class_name RandomAudioStreamPlayer2D
extends AudioStreamPlayer2D


@export_tool_button("Play Random") var play_random_action = _play_random_tool_button


## Selectively choose audio streams from
@export var audio_streams: Array[AudioStream]
## Choose all audio streams in the dir
@export_dir var audio_streams_dir: String



func play_random(from_position: float = 0.0) -> void:
	var random = audio_streams.pick_random()
	stream = random
	play(from_position)


# Plays a random sound to preview
func _play_random_tool_button():
	play_random()
	await self.finished
	stream = null
