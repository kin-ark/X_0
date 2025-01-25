extends TextureButton

@export var stars_scene: Array[PackedScene]

@export var level_number: int = 1
@export var locked: bool = true
const DISABLED_PATH = "res://Levels/Level Selection/Assets/locked.png"

func _ready():
	var texture_path = "res://Levels/Level Selection/Assets/%d.png" % level_number
	texture_normal = load(texture_path)
	texture_disabled = load(DISABLED_PATH)
	update_button_state()

func update_button_state():
	if locked:
		disabled = true
	else:
		disabled = false
		
		var stars = GameManager.level_data.get(level_number, {}).get("stars", 0)
		for i in range(stars):
			var node = stars_scene[i].instantiate()
			add_child(node)

func _on_pressed():
	if not locked:
		GameManager.load_level(level_number)
