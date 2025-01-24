extends Node2D
@onready var tile_map_layer: TileMapLayer = $TileMapLayer
@onready var player: Player = $Player

@onready var stage_manager: Node2D = $"../StageManager"

var current_path: Array[Vector2i]
			
func _unhandled_input(event: InputEvent) -> void:
	var player_position = player.global_position
	if event.is_action_pressed("left_eye"):
		var is_walkable = tile_map_layer.is_point_walkable(player_position)
		if is_walkable:
			#print("yea")
			current_path = tile_map_layer.astar.get_id_path(
				tile_map_layer.local_to_map(global_position),
				tile_map_layer.local_to_map(player_position)
			).slice(1)
			
			if current_path.is_empty(): return
			
			var target_position = tile_map_layer.map_to_local(current_path.front())
			var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
			tween.tween_property(self, "global_position", target_position, 1)
			
			if current_path.size() == 1:
				tween.tween_callback(stage_manager.fail)
			#print(current_path)
			#print(current_path)
