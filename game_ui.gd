extends CanvasLayer

@export var score_board: PackedScene
@onready var time: Label = $MarginContainer/VBoxContainer/Time
@onready var move: Label = $MarginContainer/VBoxContainer/Move

@onready var StageManager: Node2D = $"../StageManager"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StageManager.show_score.connect(show_score_board)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time.text = str(snapped(StageManager.time_elapsed, 0.01))
	move.text = str(StageManager.move_count)

func show_score_board():
	print(StageManager.move_count)
	var level_summary = score_board.instantiate()
	add_child(level_summary)
