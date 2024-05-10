shader_type canvas_item;

// Called for every pixel the material is visible on
void fragment() {
	// Get color of current pixel
	// TEXTURE = current texture, UV = current pixel
	vec4 input_color = texture(TEXTURE, UV);
	
	// Set output color to white, with same alpha as input
	//COLOR = vec4(1.0, 1.0, 1.0, input_color.a);
	
	// Same r/g/a as input, but maxed out blue
	//COLOR = vec4(input_color.r, input_color.g, 1.0, input_color.a);
	
	// Get average color
	// Setting r/g/b to this applies a greyscale effect (more or less)
	float color_average = (input_color.r + input_color.g + input_color.b) / 3.0;
	vec4 output_color = vec4(color_average, color_average, color_average, input_color.a);
	// Max red and alpha if r/g/b are all above 0.7
	if (output_color.r > 0.7 && output_color.g > 0.7 && output_color.b > 0.7) {
		output_color = vec4(1.0, 0.0, 0.0, 1.0);
	}
	COLOR = output_color;
}
