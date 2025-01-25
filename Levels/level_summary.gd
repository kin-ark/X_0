class_name LevelSummary
extends CenterContainer


@onready var v_box_container: VBoxContainer = %VBoxContainer
@onready var audio_stream_player: AudioStreamPlayer = %AudioStreamPlayer
@onready var button: Button = %Button
@onready var time_val_label: Label = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/TimeValLabel
@onready var move_val_label: Label = $VBoxContainer/PanelContainer/MarginContainer/VBoxContainer/HBoxContainer2/MoveValLabel

@onready var StageManager: Node2D = $"../../StageManager"

var tween_int_value: int

func _ready() -> void:
	edit_time_value(StageManager.time_elapsed)
	edit_move_value(StageManager.move_count)
	var rows = v_box_container.get_children()
	
	for row in rows:
		row.modulate = Color.TRANSPARENT
	
	var tween = create_tween().set_parallel()
	#tween.tween_interval(1)
	
	tween.finished.connect(func():
		button.disabled = false
	)
	
	for row in rows:
		tween.tween_property(row, 'modulate', Color.WHITE, 0.1).set_delay(1)
		tween.tween_property(self, 'tween_int_value', 0, 0)
		
		var value_node = row.get_child(1)
		
		tween.tween_method(interpolate_integers.bind(value_node), 0, int(value_node.text), 0.5).set_delay(1)
		
		tween.tween_interval(0.5)

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
