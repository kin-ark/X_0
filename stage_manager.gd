extends Node2D

var move_count = 0
var time_elapsed = 0
var is_stopped = false


enum GAME_STATE {SKILL_SELECT, PLAY, SKILL_USE, END}

var game_state: GAME_STATE = GAME_STATE.PLAY
var tile_map_layer: TileMapLayer = null
var player: Player = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if get_tree().current_scene:
		var node = get_tree().current_scene.get_node("TileMapLayer")
		if node:
			tile_map_layer = node
		else:
			print("Node not found")
		
		node = get_tree().current_scene.get_node("Player")
		if node:
			player = node
		else:
			print("Node not found")
	else:
		print("No current scene!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if !is_stopped:
		time_elapsed += delta
		#$Label.text = str(time_elapsed).pad_decimals(2)
