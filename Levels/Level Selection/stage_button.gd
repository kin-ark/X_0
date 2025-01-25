class_name StageButton
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
	print(GameManager.level_data)

func update_button_state():
	if locked:
		disabled = true
	else:
		disabled = false
		
# Clear existing stars (if any)
		for child in get_children():
			if child.is_in_group("stars"):
				child.queue_free()

		# Add and position stars
		var stars = GameManager.level_data.get(level_number, {}).get("stars", 0)
		for i in range(stars):
			var star_node = stars_scene[i].instantiate()
			star_node.add_to_group("stars")  # Add stars to a group for easy management
			add_child(star_node)

		


func _on_pressed():
	if not locked:
		GameManager.load_level(level_number)
