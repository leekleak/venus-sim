shader_type spatial;
render_mode blend_mix, depth_draw_opaque, cull_back, diffuse_lambert, specular_schlick_ggx;

uniform float black_bar: hint_range(0.0, 1.0) = 0.1;
void fragment() {
	ALBEDO = vec3(0.0);
	float lower = black_bar;
	float upper = 1.0 - black_bar;
    if (UV.x > upper || UV.y > upper || UV.x < lower || UV.y < lower) {
        ALPHA = 1.0;
    } else {
        ALPHA = 0.0;
    }
}
