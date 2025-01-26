extends TextureRect



@onready var StageManager: Node2D = $"../../StageManager"
@onready var left_button_slot: Slot = $"LeftButton"
@onready var right_button_slot: Slot = $"RightButton"
@onready var button_list: TextureRect = $"../ButtonListContainer/ButtonList"
@onready var confirm_button: TextureButton = $ConfirmButton
@onready var right_particle_spot: Marker2D = $RightButton/RightParticleSpot
@onready var left_particle_spot: Marker2D = $LeftButton/LeftParticleSpot
const EXPLOSION = preload("res://Particles/explosion.tscn")

const GREEN_FLAME = preload("res://Particles/particle_green.tscn")
const PINK_FLAME = preload("res://Particles/particle_pink.tscn")
const PURPLE_FLAME = preload("res://Particles/particle_purple.tscn")
const RED_FLAME = preload("res://Particles/particle_red.tscn")
const BLUE_FLAME = preload("res://Particles/particle_blue.tscn")
var fire_lut = {"Break":BLUE_FLAME, "Jump":PURPLE_FLAME, "Possess":GREEN_FLAME, "Push":PINK_FLAME, "Restoration":RED_FLAME}
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_confirm_button_pressed() -> void:

	StageManager.player.skill_1 = left_button_slot.texture_rect.property["BUTTON"]
	
	StageManager.player.skill_2 = right_button_slot.texture_rect.property["BUTTON"]
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC).set_parallel()
	tween.tween_property(button_list, "global_position", button_list.global_position + Vector2(1920, 0), 1).set_ease(Tween.EASE_IN_OUT)
	tween.tween_property(confirm_button, "global_position", confirm_button.global_position - Vector2(1920, 0), 1).set_ease(Tween.EASE_IN_OUT)
	
	
	get_parent().start_countdown()


func _on_player_destroy_button_left() -> void:
	print("l")
	await get_tree().create_timer(0.3).timeout
	left_button_slot.hide()
	left_particle_spot.hide()
	var _particle = EXPLOSION.instantiate()
	get_tree().current_scene.add_child(_particle)
	_particle.global_position = left_particle_spot.global_position
	_particle.emitting = true


func _on_player_destroy_button_right() -> void:
	print("r")
	await get_tree().create_timer(0.3).timeout
	right_button_slot.hide()
	right_particle_spot.hide()
	var _particle = EXPLOSION.instantiate()
	add_child(_particle)
	_particle.global_position = right_particle_spot.global_position
	_particle.emitting = true


func _on_player_use_button_left() -> void:
	left_particle_spot.show()
	if not StageManager.player.skill_1: return
	print(StageManager.player.skill_1.skill_name)
	var particle = fire_lut[StageManager.player.skill_1.skill_name].instantiate()
	left_particle_spot.add_child(particle)



func _on_player_use_button_right() -> void:
	right_particle_spot.show()
	if not StageManager.player.skill_2: return
	print(StageManager.player.skill_2)
	var particle = fire_lut[StageManager.player.skill_2.skill_name].instantiate()
	right_particle_spot.add_child(particle)



func _on_player_use_restoration() -> void:
	print("kepanggil")
	left_button_slot.visible = true
	right_button_slot.visible = true
