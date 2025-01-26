extends Control

@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	update_level_buttons()

func update_level_buttons():
	for button in get_tree().get_nodes_in_group("level_buttons"):
		var level_number = button.level_number
		button.locked = !GameManager.is_level_unlocked(level_number)
		button.update_button_state()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_next_button_pressed() -> void:
	audio_stream_player.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Levels/Level Selection/level_selection2.tscn")
	


func _on_back_button_pressed() -> void:
	audio_stream_player.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Levels/Level Selection/level_selection.tscn")
