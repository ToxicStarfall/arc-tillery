@tool
## Plays a random audio stream out of the selecetd audio streams.
class_name RandomAudioStreamPlayer2D
extends AudioStreamPlayer2D


@export_tool_button("Play Random") var play_random_action = _play_random_tool_button


## Selectively choose audio streams from
@export var audio_streams: Array[AudioStream]
## Choose all audio streams in the dir
@export_dir var audio_streams_dir: String


func _ready() -> void:
	# Automatically adds AudioStream(s) in dir to audio_streams array.
	if !audio_streams_dir.is_empty():
		for file in ResourceLoader.list_directory(audio_streams_dir):
			if !file.ends_with("/"):
				var res = ResourceLoader.load(audio_streams_dir + "/" + file)
				if !audio_streams.has(res):
					audio_streams.append(res)


func play_random(from_position: float = 0.0) -> void:
	var random = audio_streams.pick_random()
	stream = random
	play(from_position)


# Plays a random sound to preview
func _play_random_tool_button():
	play_random()
	await self.finished
	stream = null
