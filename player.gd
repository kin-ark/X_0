extends Sprite2D
class_name Player

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var sprite_2d: Sprite2D = $Sprite2D

var is_moving = false

func _physics_process(delta: float) -> void:
	if not is_moving:
		return
	
	if global_position == sprite_2d.global_position:
		is_moving = false
		return
	
	sprite_2d.global_position = sprite_2d.global_position.move_toward(global_position, 1)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
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


func _move(direction):
	var curr_tile = tile_map_layer.local_to_map(global_position)
	
	var next_tile = Vector2i(curr_tile.x + direction.x, curr_tile.y + direction.y)
	
	var tile_data = tile_map_layer.get_cell_tile_data(next_tile)
	
	if tile_data == null or tile_data.get_custom_data("walkable") == false:
		return
	
	is_moving = true
	global_position = tile_map_layer.map_to_local(next_tile)
	sprite_2d.global_position = tile_map_layer.map_to_local(curr_tile)
