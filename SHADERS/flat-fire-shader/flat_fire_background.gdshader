shader_type canvas_item;

uniform float yoffset = 0.5;
uniform float animation_speed = 0.5;
uniform vec4 flame_color : source_color = vec4(1.0);
uniform sampler2D noise_texture : hint_default_black, repeat_enable;

void fragment() {
	vec2 uv = vec2(UV.x, UV.y + TIME * animation_speed); // Use time to maniplate y value of pixel we are sampling
	vec4 noise_color = texture(noise_texture, uv);
	vec4 final_color = noise_color;
	final_color.rgb += vec3(UV.y - yoffset); // Make texture brighter as you go further down the screen
	final_color.rgb = step(final_color.rgb, vec3(0.5)); // Returns 0 if color above 0.5, 1 otherwise
	final_color.rgb = vec3(1.0) - final_color.rgb; // Invert colors
	final_color.a = final_color.r; // Set alpha to red value so black pixels are transparent
	final_color.rgb = flame_color.rgb;
	COLOR = final_color;
}
