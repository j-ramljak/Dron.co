shader_type spatial;

render_mode cull_disabled, depth_prepass_alpha, unshaded, shadows_disabled;

uniform sampler2D color;
uniform sampler2D alpha : repeat_disable;

void fragment() {
	ALBEDO = texture(color, UV).xyz;
	ALPHA = pow(texture(alpha, UV2).x, 2.2);
}
