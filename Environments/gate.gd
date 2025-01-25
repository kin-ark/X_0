extends Area2D
class_name Gate
enum DIRECTION {LEFT, RIGHT, UP, DOWN}
@export var open_direction: DIRECTION
var lut = [Vector2.LEFT, Vector2.RIGHT, Vector2.UP, Vector2.DOWN]
var origin: Vector2
var target: Vector2


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	origin = global_position
	target = origin + lut[open_direction] * StageManager.tile_size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func open():

	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position", target, 0.25)
	
func close():
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self, "global_position", origin, 0.25)
