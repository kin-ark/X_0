extends CanvasLayer

@onready var h_box_container: HBoxContainer = $HBoxContainer
@onready var setting_layer: Control = $SettingLayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_close_button_pressed() -> void:
	get_tree().quit()

func _on_play_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Levels/level1.tscn")

# flow
# case: belum pernah main
# play button -> cutscene lore -> tutorial (stage 1) -> stage selection -> pilih stage atau exit
# case: udah pernah main
# play button -> stage selection -> bla bla bla

func _on_setting_button_pressed() -> void:
	h_box_container.hide()
	setting_layer.show()


func _on_back_button_pressed() -> void:
	h_box_container.show()
	setting_layer.hide()
