extends Node
const JUMP = preload("res://Skills/jump.tscn")
var skill_1: Node = null
var skill_2: Node = null



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if StageManager.game_state == StageManager.GAME_STATE.PLAY:
		if Input.is_action_just_pressed("left_eye"):
			if skill_1:
				StageManager.game_state = StageManager.GAME_STATE.SKILL_USE
				skill_1.use()
				
	# coba main
	elif StageManager.game_state == StageManager.GAME_STATE.SKILL_SELECT:
		if Input.is_action_just_pressed("right_eye"):
			StageManager.game_state = StageManager.GAME_STATE.PLAY
