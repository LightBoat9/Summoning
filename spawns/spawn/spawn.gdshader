shader_type canvas_item;

uniform bool flash = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 textureColor = texture(TEXTURE, UV);
	
	if (flash && textureColor.a > 0.0) {
		COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
