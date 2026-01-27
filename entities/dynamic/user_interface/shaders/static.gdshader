shader_type canvas_item;

uniform float amount = 40.0;

void fragment() {
	vec2 resolution = 1.0 / SCREEN_PIXEL_SIZE;
	float pixel_size = 4.0;
	vec2 uv = floor(UV * resolution / pixel_size) / resolution * pixel_size;
	float a = fract(sin(dot(uv, vec2(12.9898, 78.233) * TIME)) * 438.5453) * 1.9;
	COLOR = vec4(vec3(0.75), clamp(a, 0.0, 1.0) - 0.5);
}