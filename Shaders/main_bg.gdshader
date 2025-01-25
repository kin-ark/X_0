shader_type canvas_item;

uniform float normal_offset : hint_range(0, 20, .1) = 1.5;
uniform float time_influence : hint_range(0, 50) = 3;
uniform float y_div : hint_range(0, 10, .1) = 2.87;

void vertex() {
	VERTEX.x += sin(VERTEX.y * y_div + round(TIME * time_influence)) * normal_offset;
	VERTEX.y += sin(VERTEX.x * y_div + round(TIME * time_influence)) * normal_offset;
}

void fragment() {
	// Called for every pixel the material is visible on.
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
