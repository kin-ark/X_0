extends PanelContainer
class_name Slot

@onready var texture_rect: SlotData = $TextureRect

var filled : bool = false
 
func _get_drag_data(at_position):
 
	set_drag_preview(get_preview())

	return texture_rect
 
func _can_drop_data(_pos, data):
	return data is SlotData
 
func _drop_data(_pos, data):
	if texture_rect.lock_content and texture_rect.button_bak:
		if texture_rect.button_bak.button_name != data.property["BUTTON"].button_name:
			return
	var temp = texture_rect.property
	texture_rect.property = data.property
	data.property = temp
	
func get_preview():
	var preview_texture = TextureRect.new()
 
	preview_texture.texture = texture_rect.texture
	preview_texture.expand_mode = 1
	preview_texture.size = Vector2(128,128)
	preview_texture.position = Vector2(-64,-64)
	var preview = Control.new()

	preview.add_child(preview_texture)

 
	return preview
