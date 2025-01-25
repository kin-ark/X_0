extends TextureRect


@onready var StageManager: Node2D = $"../../StageManager"
@onready var left_button_slot: Slot = $"Left Button"
@onready var right_button_slot: Slot = $"Right Button"
@onready var button_list: TextureRect = $"../ButtonList"


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if StageManager.game_state == StageManager.GAME_STATE.SKILL_SELECT:
		pass


func _on_confirm_button_pressed() -> void:

	StageManager.player.skill_1 = left_button_slot.texture_rect.property["BUTTON"]
	
	StageManager.player.skill_2 = right_button_slot.texture_rect.property["BUTTON"]
	
	var tween = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(button_list, "global_position", button_list.global_position + Vector2(1920, 0), 1).set_ease(Tween.EASE_IN_OUT)
	StageManager.game_state = StageManager.GAME_STATE.PLAY
