shader_type spatial;
render_mode depth_test_disabled;

uniform vec3 color : source_color = vec3(1,1,1);

void vertex() {
	// Called for every vertex the material is visible on.
}

//uniform vec3 = 

void fragment() {
	//ALBEDO = vec3(1.0 ,0.0 ,0.0 );
	// Called for every pixel the material is visible on.
	ALBEDO = color;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
