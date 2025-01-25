extends TextureRect
class_name SlotData
 
@export var lock_content: bool = false

@export var button: SkillResource:
	set(value):
		button = value

 
@onready var property: Dictionary = {"TEXTURE": texture,
									 "BUTTON": button}:
	set(value):
		property = value
 		
 		
		
		if property["BUTTON"] and property["BUTTON"] is SkillResource:
			texture = property["BUTTON"].sprite
			button = property["BUTTON"]
		else:
			button = null
			texture = null
			
var button_bak = null


func _ready() -> void:
	button_bak = button
	if property["BUTTON"] and property["BUTTON"] is SkillResource:
		texture = property["BUTTON"].sprite
	
	print(button_bak)
	
