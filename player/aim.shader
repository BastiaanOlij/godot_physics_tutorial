shader_type spatial;
render_mode cull_disabled, unshaded;

uniform vec3 velocity = vec3(0.0, 10.0, -15.0);
uniform float gravity = 9.8;

uniform float slices = 20.0;
uniform float scale = 5.0;

void vertex() {
	// we'll be calculating our own vertex
	VERTEX.x = 0.0;
	VERTEX.y = VERTEX.z;
	VERTEX.z = 0.0;
	
	// apply our velocity
	VERTEX += velocity * UV.x;
	
	// apply our gravity
	VERTEX.y -= 0.5 * gravity * UV.x * UV.x;
}

void fragment() {
	// discard our fragment at intervals
	if (mod(UV.x * slices - TIME * scale, 1.0) > 0.5) {
		discard;
	}
}





