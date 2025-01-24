extends Node2D

var move_count = 0
var time_elapsed = 0
var is_stopped = false


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_stopped:
		time_elapsed += delta
		#$Label.text = str(time_elapsed).pad_decimals(2)


func fail():
	print("fail")
