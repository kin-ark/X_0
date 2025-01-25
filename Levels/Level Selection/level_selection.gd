extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	update_level_buttons()

func update_level_buttons():
	for button in get_tree().get_nodes_in_group("level_buttons"):
		var level_number = button.level_number
		button.locked = !GameManager.is_level_unlocked(level_number)
		button.update_button_state()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
