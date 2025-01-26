extends CanvasLayer

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("pause")):
		pause_unpause()

func pause_unpause():
	audio_stream_player.play()
	if get_tree().paused == true:
		$".".hide()
		get_tree().paused = false
	elif get_tree().paused == false:
		$".".show()
		get_tree().paused = true

func exit():
	audio_stream_player.play()
	get_tree().quit()

func restart():
	get_tree().paused = false
	audio_stream_player.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().reload_current_scene()
