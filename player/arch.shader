shader_type spatial;
render_mode cull_disabled, unshaded;

uniform float radius = 2.0;
uniform float angle = 0.5;

void vertex() {
	float PI = 3.1415926535;
	float a = (VERTEX.z + 1.0) * 0.5 * angle;
	
	VERTEX.y = (radius + VERTEX.x) * sin(a);
	VERTEX.z = -(radius + VERTEX.x) * cos(a);
	VERTEX.x = 0.0;
}
