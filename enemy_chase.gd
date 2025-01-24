extends Node2D
@onready var ray_cast_2d: RayCast2D = $RayCast2D
var current_path: Array[Vector2i]
func move() -> bool:
	var player_position = StageManager.player.global_position
	var is_walkable = StageManager.tile_map_layer.is_point_walkable(player_position)
	if is_walkable:
		#print("yea")
		current_path = StageManager.tile_map_layer.astar.get_id_path(
			StageManager.tile_map_layer.local_to_map(global_position),
			StageManager.tile_map_layer.local_to_map(player_position)
		).slice(1)

		if current_path.is_empty(): return false

		var target_position = StageManager.tile_map_layer.map_to_local(current_path.front())
		var direction = Vector2(target_position - global_position).normalized()
		#print(target_position, global_position)
		ray_cast_2d.target_position = direction * 64
	
		ray_cast_2d.force_raycast_update()
	
		if ray_cast_2d.is_colliding():
			var collider = ray_cast_2d.get_collider()
			if collider:
				return false
		var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
		tween.tween_property(self, "global_position", target_position, 0.2)

		if current_path.size() == 1:
			tween.tween_callback(StageManager.fail)
		#print(current_path)
		#print(current_path)
		return true
	return false
