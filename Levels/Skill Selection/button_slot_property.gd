extends TextureRect
 

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


func _ready() -> void:
	if property["BUTTON"] and property["BUTTON"] is SkillResource:
		texture = property["BUTTON"].sprite
