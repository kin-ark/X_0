extends Node2D
class_name Player

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var sprite_2d: Sprite2D = $Sprite
@onready var target: Sprite2D = $Target

var is_moving = false

	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if StageManager.game_state == StageManager.GAME_STATE.PLAY:
		if is_moving:
			return
		if Input.is_action_pressed("up"):
			_move(Vector2.UP)
		elif Input.is_action_pressed("down"):
			_move(Vector2.DOWN)
		elif Input.is_action_pressed("left"):
			_move(Vector2.LEFT)
		elif Input.is_action_pressed("right"):
			_move(Vector2.RIGHT)

func _set_is_moving(val):
	is_moving = val


func get_next_tile(direction) -> Vector2i:
	var curr_tile = tile_map_layer.local_to_map(global_position)
	
	var next_tile = Vector2i(curr_tile.x + direction.x, curr_tile.y + direction.y)
	
	var tile_data = tile_map_layer.get_cell_tile_data(next_tile)
	
	if tile_data == null or tile_data.get_custom_data("walkable") == false:
		return Vector2i(999,999)
	
	return next_tile

func move(next_tile):
	global_position = tile_map_layer.map_to_local(next_tile)


func _move(direction):

	var next_tile = get_next_tile(direction)
	if next_tile == Vector2i(999, 999): return
	is_moving = true
	
	var curr_tile = tile_map_layer.local_to_map(global_position)
	move(next_tile)
	sprite_2d.global_position = tile_map_layer.map_to_local(curr_tile)
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(sprite_2d, "global_position", tile_map_layer.map_to_local(next_tile), 1)
	tween.tween_callback(_set_is_moving.bind(false))
	#sprite_2d.global_position = tile_map_layer.map_to_local(curr_tile)
