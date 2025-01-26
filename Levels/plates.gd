extends Area2D
class_name Plate

@export var gates: Array[Gate]


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#assert(gate != null, "Gate must be assigned to each plates")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_entered(area: Area2D) -> void:
	for gate in gates:
		gate.open()

func _on_area_exited(area: Area2D) -> void:
	for gate in gates:
		gate.close()
