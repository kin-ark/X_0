class_name LevelSummary
extends CenterContainer

@export var star1: PackedScene
@export var star2: PackedScene
@export var star3: PackedScene

@onready var v_box_container: VBoxContainer = %VBoxContainer
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
#@onready var button: Button = %Button
@onready var time_val_label: Label = %TimeValLabel
@onready var move_val_label: Label = %MoveValLabel
@onready var summary_bg: TextureRect = %SummaryBG

@onready var StageManager: Node2D = $"../../StageManager"
@onready var audio_stream_player_2: AudioStreamPlayer = $AudioStreamPlayer2

var tween_int_value: int

func _ready() -> void:
	edit_time_value(int(StageManager.time_elapsed))
	edit_move_value(StageManager.move_count)
	var rows = v_box_container.get_children()
	
	for row in rows:
		row.modulate = Color.TRANSPARENT
	
	var tween = create_tween().set_parallel()
	#tween.tween_interval(1)
	
	#tween.finished.connect(func():
		#button.disabled = false
	#)
	
	for row in rows:
		tween.tween_property(row, 'modulate', Color.WHITE, 0.1).set_delay(1)
		tween.tween_property(self, 'tween_int_value', 0, 0)
		
		var value_node = row.get_child(1)
		
		tween.tween_method(interpolate_integers.bind(value_node), 0, int(value_node.text), 0.5).set_delay(1)
		
		tween.tween_interval(0.5)

	var stars = GameManager.calculate_stars(GameManager.current_level, StageManager.move_count, StageManager.time_elapsed)
	print("Level Complete! Stars: ", stars)
	
	 #Star 1
	var star1_instance = star1.instantiate()
	star1_instance.mouse_filter = Control.MOUSE_FILTER_IGNORE
	summary_bg.add_child(star1_instance)
	 #Fade in and scale up
	tween.tween_property(star1_instance, "modulate:a", 1.0, 0.5).from(0.0)
	tween.tween_property(star1_instance, "scale", Vector2(1, 1), 0.5).from(Vector2(0.5, 0.5))
	
	if stars >= 3:
		var star3_instance = star3.instantiate()
		star3_instance.mouse_filter = Control.MOUSE_FILTER_IGNORE
		summary_bg.add_child(star3_instance)
		tween.tween_property(star3_instance, "modulate:a", 1.0, 0.5).from(0.0)
		tween.tween_property(star3_instance, "scale", Vector2(1, 1), 0.5).from(Vector2(0.5, 0.5))
	
	if stars >= 2:
		var star2_instance = star2.instantiate()
		star2_instance.mouse_filter = Control.MOUSE_FILTER_IGNORE
		summary_bg.add_child(star2_instance)
		tween.tween_property(star2_instance, "modulate:a", 1.0, 0.5).from(0.0)
		tween.tween_property(star2_instance, "scale", Vector2(1, 1), 0.5).from(Vector2(0.5, 0.5))

func interpolate_integers(current, value_node):
	if current > tween_int_value:
		tween_int_value = current
		if not audio_stream_player.playing:
			audio_stream_player.play()

	value_node.text = str(current)

func edit_time_value(time: float):
	time_val_label.text = str(time)

func edit_move_value(count: int):
	move_val_label.text = str(count)


func _on_next_button_pressed() -> void:
	audio_stream_player_2.play()
	GameManager.unlock_next_level(GameManager.current_level)
	GameManager.save_game()
	GameManager.load_level(GameManager.current_level + 1)


func _on_home_button_pressed() -> void:
	audio_stream_player_2.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Common/Main Menu/main_menu.tscn")


func _on_selection_button_pressed() -> void:
	audio_stream_player_2.play()
	TransitionScreen.transition()
	await TransitionScreen.on_transition_finished
	get_tree().change_scene_to_file("res://Levels/Level Selection/level_selection.tscn")
