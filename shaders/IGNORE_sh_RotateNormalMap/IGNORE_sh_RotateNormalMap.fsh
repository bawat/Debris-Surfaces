//
// Simple passthrough fragment shader
//
varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_Rotation;

void main()
{
	vec4 normalColour = texture2D( gm_BaseTexture, v_vTexcoord );
	vec3 normal = (normalColour.rgb-0.5) * 2.0;
	mat3 rotationMatrix = mat3(cos(u_Rotation), -sin(u_Rotation), 0.0,
							   sin(u_Rotation),  cos(u_Rotation), 0.0,
							   0.0			  , 0.0               , 1.0);
	vec3 rotatedNormal = (rotationMatrix * normal)/2.0 + 0.5;
	normalColour = vec4(rotatedNormal, normalColour.a);
    gl_FragColor = v_vColour * normalColour;
}