extends CanvasLayer


func _unhandled_input(event: InputEvent) -> void:
	if (event.is_action_pressed("pause")):
		pause_unpause()

func pause_unpause():
	if get_tree().paused == true:
		$".".hide()
		get_tree().paused = false
	elif get_tree().paused == false:
		$".".show()
		get_tree().paused = true

func exit():
	get_tree().quit()

func restart():
	get_tree().paused = false
	get_tree().reload_current_scene()
