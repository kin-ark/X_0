extends Area2D
class_name Plate

@export var gates: Array[Gate]
const PRESSUREPLATE_OFF = preload("res://Environments/Visual Assets/pressureplate.png")
const PRESSUREPLATE_ON  = preload("res://Environments/Visual Assets/pressureplate1.png")
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#assert(gate != null, "Gate must be assigned to each plates")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	sprite_2d.texture = PRESSUREPLATE_ON
	audio_stream_player.play()
	for gate in gates:
		gate.open()

func _on_area_exited(area: Area2D) -> void:
	audio_stream_player.play()
	sprite_2d.texture = PRESSUREPLATE_OFF
	for gate in gates:
		gate.close()
