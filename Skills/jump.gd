extends BaseSkill

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print("ah")
	if StageManager.game_state == StageManager.GAME_STATE.SKILL_USE:
		var target_position = StageManager.tile_map_layer.map_to_local(get_global_mouse_position())
		print(target_position)

func use():
	print("asu")
	var curr_position = StageManager.tile_map_layer.local_to_map(StageManager.player.global_position)
	for i in range(-1, 2):
		for j in range(-1, 2):
			var coords = curr_position + Vector2i(i, j)
			var tile_data = StageManager.tile_map_layer.get_cell_tile_data(coords)
			if tile_data and (tile_data.get_custom_data("walkable") == false):	
				print(coords, Vector2i(i, j))
