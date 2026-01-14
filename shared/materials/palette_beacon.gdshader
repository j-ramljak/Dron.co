shader_type spatial;

render_mode cull_disabled, unshaded, shadows_disabled, depth_draw_always;

uniform sampler2D color;
uniform sampler2D alpha : repeat_disable;

void fragment() {
	ALBEDO = texture(color, UV).xyz;
	ALPHA = pow(texture(alpha, UV2).x, 2.2);
}
