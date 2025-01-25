extends CanvasLayer
@onready var time: Label = $Time
@onready var move: Label = $Move
@export var score_board: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	StageManager.show_score.connect(show_score_board)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time.text = str(StageManager.time_elapsed)
	move.text = str(StageManager.move_count)

func show_score_board():
	var level_summary = score_board.instantiate()
	add_child(level_summary)
