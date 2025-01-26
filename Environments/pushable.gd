extends Area2D
class_name Pushable
@onready var ray_cast_2d: RayCast2D = $RayCast2D
@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var StageManager: Node2D = $"../../StageManager"
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


func get_next_tile(direction) -> Vector2i:
	var tile_map_layer = StageManager.tile_map_layer
	var curr_tile = tile_map_layer.local_to_map(global_position)
	
	var next_tile = Vector2i(curr_tile.x + direction.x, curr_tile.y + direction.y)
	
	var tile_data = tile_map_layer.get_cell_tile_data(next_tile)
	
	if tile_data == null or tile_data.get_custom_data("walkable") == false:
		return Vector2i(999,999)
	
	return next_tile


func move(direction) -> bool:
	var tile_map_layer = StageManager.tile_map_layer
	var curr_tile = tile_map_layer.local_to_map(global_position)
	var next_tile = Vector2i(curr_tile.x + direction.x, curr_tile.y + direction.y)
	var tile_data = tile_map_layer.get_cell_tile_data(next_tile)
	
	if tile_data == null:
		return false
		
	ray_cast_2d.target_position = direction * StageManager.tile_size
	
	ray_cast_2d.force_raycast_update()
	
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider is not Plate:
			return false

	elif tile_data.get_custom_data("walkable") == false:
			return false
			
	audio_stream_player.play()

	global_position = StageManager.tile_map_layer.map_to_local(next_tile)
	sprite_2d.global_position = tile_map_layer.map_to_local(curr_tile)
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(sprite_2d, "global_position", tile_map_layer.map_to_local(next_tile), 0.2)

	return true
	
	#sprite_2d.global_position = tile_map_layer.map_to_local(curr_tile)
	
