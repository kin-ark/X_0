extends Node2D

signal show_score
signal show_fail

@export var tile_size: int = 86

var move_count = 0
var time_elapsed = 0
var is_stopped = false

enum GAME_STATE {SKILL_SELECT, PLAY, ENEMY, SKILL_USE, END}

var game_state: GAME_STATE = GAME_STATE.SKILL_SELECT

var player_win: bool = false


@onready var tile_map_layer: PlayableArea = $"../TileMapLayer"
@onready var player: Player = $"../Player"
@onready var enemies: Node = $"../Enemies"
@onready var environments: Node = $"../Environments"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_state != GAME_STATE.SKILL_SELECT && game_state != GAME_STATE.END:
		time_elapsed += delta
		#$Label.text = str(time_elapsed).pad_decimals(2)
		
func start_game():
	game_state = GAME_STATE.PLAY
	
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
	if environments:
		for environment in environments.get_children():
			if coords == tile_map_layer.local_to_map(environment.global_position)\
			and environment is not Plate:
				return true
			
	return false


func fail():
	print("fail")
	game_state = GAME_STATE.END
	show_fail.emit()

func win():
	print("win")
	game_state = GAME_STATE.END
	show_score.emit()
	print(move_count)
	print(time_elapsed)
	player_win = true
	GameManager.unlock_next_level(GameManager.current_level)
