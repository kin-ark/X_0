extends Area2D
class_name Breakable
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer
@onready var collision_shape_2d: CollisionShape2D = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func break_wall():
	collision_shape_2d.disabled = true
	audio_stream_player.play()
	await get_tree().create_timer(0.1).timeout
	queue_free()
