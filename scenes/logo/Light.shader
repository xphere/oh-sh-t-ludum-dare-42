shader_type canvas_item;

uniform sampler2D light : hint_black;
uniform vec2 light_position = vec2(0, 0);
uniform float light_power : hint_range(0, 1) = 1.0;

void fragment() {
	vec4 color = texture(TEXTURE, UV);
	vec4 light_color = texelFetch(light, ivec2(UV / TEXTURE_PIXEL_SIZE - light_position), 0);
	if (light_color.a * color.a > 0.0) {
		color = mix(color, light_color, light_power);
	}
	COLOR = color;
}
