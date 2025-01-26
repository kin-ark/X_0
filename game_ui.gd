extends CanvasLayer

@export var score_board: PackedScene
@onready var time: Label = $MarginContainer/VBoxContainer/Time
@onready var move: Label = $MarginContainer/VBoxContainer/Move
@onready var black_overlay: TextureRect = $BlackOverlay
@onready var StageManager: Node2D = $"../StageManager"

const COUNTDOWN_LABEL = preload("res://Levels/UI/countdown_label.tscn")
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StageManager.show_score.connect(show_score_board)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time.text = str(snapped(StageManager.time_elapsed, 0.01))
	move.text = str(StageManager.move_count)
	
func start_countdown():
	var countdown = COUNTDOWN_LABEL.instantiate()
	add_child(countdown)
	await get_tree().create_timer(3.5).timeout
	var tween = get_tree().create_tween()
	tween.tween_property(black_overlay, "modulate", Color(25, 25, 38, 0), 0.15)
	StageManager.start_game()
	
	

func show_score_board():
	print(StageManager.move_count)
	var level_summary = score_board.instantiate()
	add_child(level_summary)
