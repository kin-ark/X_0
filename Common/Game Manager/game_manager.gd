extends Node

var unlocked_levels: int = 1  # Start with level 1 unlocked
var save_path: String = "user://save_game.dat"
var level_data: Dictionary = {}  # Stores star ratings and requirements for each level
var current_level: int

func _ready():
	load_game()

func initialize_level_data():
	# Define requirements for each level (move limit, time limit, etc.)
	level_data = {
		1: {"moves": 10, "time": 20.0, "stars": 0},
		2: {"moves": 10, "time": 20.0, "stars": 0},
		3: {"moves": 10, "time": 20.0, "stars": 0},
		4: {"moves": 10, "time": 20.0, "stars": 0},
		5: {"moves": 10, "time": 20.0, "stars": 0},
		6: {"moves": 10, "time": 20.0, "stars": 0},
		7: {"moves": 10, "time": 20.0, "stars": 0},
		8: {"moves": 10, "time": 20.0, "stars": 0},
		9: {"moves": 10, "time": 20.0, "stars": 0},
		10: {"moves": 10, "time": 20.0, "stars": 0},
		11: {"moves": 10, "time": 20.0, "stars": 0},
		12: {"moves": 10, "time": 20.0, "stars": 0},
		# Add more levels as needed
	}

func calculate_stars(level_number: int, moves: int, time: float) -> int:
	if level_number not in level_data:
		return 0  # Level not found

	var requirements = level_data[level_number]
	var stars = 1
	
	# Calculate stars based on requirements
	if moves <= requirements["moves"]:
		stars += 1
	if time <= requirements["time"]:
		stars += 1
	
	# Save the star rating
	level_data[level_number]["stars"] = stars
	save_game()
	
	return stars

func unlock_next_level(current_level: int):
	if current_level >= unlocked_levels:
		unlocked_levels = current_level + 1
		save_game()

func is_level_unlocked(level_number: int) -> bool:
	return level_number <= unlocked_levels

func load_level(level_number: int):
	if is_level_unlocked(level_number):
		var level_path = "res://Levels/level%d.tscn" % level_number
		if ResourceLoader.exists(level_path):
			current_level = level_number
			TransitionScreen.transition()
			await TransitionScreen.on_transition_finished
			get_tree().change_scene_to_file(level_path)
		else:
			print("Level %d does not exist!" % level_number)
	else:
		print("Level %d is locked!" % level_number)

func save_game():
	var save_data = {
		"unlocked_levels": unlocked_levels,
		"level_data": level_data  # Save star ratings and requirements
	}
	var file = FileAccess.open(save_path, FileAccess.WRITE)
	file.store_var(save_data)
	file.close()

func load_game():
	if FileAccess.file_exists(save_path):
		var file = FileAccess.open(save_path, FileAccess.READ)
		var save_data = file.get_var()
		file.close()
		unlocked_levels = save_data["unlocked_levels"]
		level_data = save_data.get("level_data", {})
	else:
		print("No save file found. Starting fresh.")
		initialize_level_data()

func reset_game():
	unlocked_levels = 1
	save_game()
