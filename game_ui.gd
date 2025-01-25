extends CanvasLayer
@onready var time: Label = $Time
@onready var move: Label = $Move


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	time.text = str(StageManager.time_elapsed)
	move.text = str(StageManager.move_count)
