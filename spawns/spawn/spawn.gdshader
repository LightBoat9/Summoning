shader_type canvas_item;

uniform bool flash = false;
uniform bool stunned = false;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 textureColor = texture(TEXTURE, UV);
	
	if (flash && textureColor.a > 0.0) {
		COLOR = vec4(1.0, 1.0, 1.0, 1.0);
	}
	else if (stunned && textureColor.a > 0.0) {
		float gray = 0.2989 * textureColor.r + 0.5870 * textureColor.g + 0.1140 * textureColor.b;
		COLOR = vec4(gray, gray, gray, 1.0);
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
