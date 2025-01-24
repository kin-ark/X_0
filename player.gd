extends Node2D
class_name Player

@onready var tile_map_layer: TileMapLayer = $"../TileMapLayer"
@onready var sprite_2d: Sprite2D = $Sprite
@onready var target: Sprite2D = $Target
@onready var ray_cast_2d: RayCast2D = $RayCast2D

var is_moving = false

@export var skill_1: SkillResource
@export var skill_2: SkillResource

var is_skill_1_active: bool = false
var is_skill_2_active: bool = false

var used_skill: SkillResource = null


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
		elif Input.is_action_pressed("left_eye"):
			is_skill_1_active = true
		elif Input.is_action_pressed("right_eye"):
			is_skill_2_active = true

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

func check_skill(skill_name):
	if (skill_1 and is_skill_1_active and skill_1.skill_name == skill_name):
		is_skill_1_active = false
		used_skill = skill_1
		skill_1 = null
		return true
	elif (skill_2 and is_skill_2_active and skill_2.skill_name == skill_name):
		is_skill_2_active = false
		used_skill = skill_2
		skill_2 = null
		return true
	return false

func _move(direction):
	var curr_tile = tile_map_layer.local_to_map(global_position)
	var next_tile = Vector2i(curr_tile.x + direction.x, curr_tile.y + direction.y)
	var tile_data = tile_map_layer.get_cell_tile_data(next_tile)
	
	if tile_data == null:
		return
		
	ray_cast_2d.target_position = direction * 64
	
	ray_cast_2d.force_raycast_update()
	
	if ray_cast_2d.is_colliding():
		var collider = ray_cast_2d.get_collider()
		if collider is Breakable and check_skill("Break"):
			collider.break_wall()
		else:
			return

	elif tile_data.get_custom_data("walkable") == false:
		
		if check_skill("Jump"):
			var jump_tile = Vector2i(next_tile.x + direction.x, next_tile.y + direction.y)
			var jump_tile_data = tile_map_layer.get_cell_tile_data(jump_tile)

			if jump_tile_data == null or jump_tile_data.get_custom_data("walkable") == false:
				return
			
			next_tile = jump_tile
		else:
			print("gabisa")
			return
	
	is_moving = true
	move(next_tile)
	sprite_2d.global_position = tile_map_layer.map_to_local(curr_tile)
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_SINE)
	tween.tween_property(sprite_2d, "global_position", tile_map_layer.map_to_local(next_tile), 0.2)
	tween.tween_callback(on_finish_move)
	
	#sprite_2d.global_position = tile_map_layer.map_to_local(curr_tile)
	
	
func on_finish_move():
	_set_is_moving(false)
	StageManager.move_enemies()
