extends Node2D

signal show_score

var move_count = 0
var time_elapsed = 0
var is_stopped = false

enum GAME_STATE {SKILL_SELECT, PLAY, ENEMY, SKILL_USE, END}

var game_state: GAME_STATE = GAME_STATE.PLAY
var tile_map_layer: TileMapLayer = null
var player: Player = null
var enemies: Node = null
var environments: Node = null
var player_win: bool = false
var level_summary = null

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
			
		node = get_tree().current_scene.get_node("Enemies")
		if node:
			enemies = node
		else:
			print("Node not found")
			
		node = get_tree().current_scene.get_node("Environments")
		if node:
			environments = node
		else:
			print("Node not found")
	else:
		print("No current scene!")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_state != GAME_STATE.SKILL_SELECT && game_state != GAME_STATE.END:
		time_elapsed += delta
		#$Label.text = str(time_elapsed).pad_decimals(2)

func move_enemies():
	game_state = GAME_STATE.ENEMY
	tile_map_layer.calculate_path()
	for stuff in enemies.get_children():
		if stuff.move():
			await get_tree().create_timer(0.2).timeout
	game_state = GAME_STATE.PLAY

func possess_enemies(direction):
	var moved = false
	for stuff in enemies.get_children():
		if stuff.move_direction(direction):
			moved = true
	return moved

func is_blocked(coords):
	for environment in environments.get_children():
		if coords == tile_map_layer.local_to_map(environment.global_position):
			return true
			
	return false

func fail():
	print("fail")
	game_state = GAME_STATE.END

func win():
	print("win")
	game_state = GAME_STATE.END
	show_score.emit()
	player_win = true
