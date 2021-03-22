//
// Simple passthrough fragment shader
//
uniform float uTime;

varying vec2 v_vTextureCoord;
varying vec2 v_vNormalTexcoord;
varying vec2 v_vSpecularTexcoord;
uniform sampler2D normalMap;              // (u,v)
uniform sampler2D specularMap;              // (u,v)
//varying vec4 v_vColour;

void main()
{
	vec3 sunDirection = normalize(vec3(cos(uTime) , sin(uTime), 0.1));
	
	vec4 diffuse = texture2D( gm_BaseTexture, v_vTextureCoord );
	vec4 normalColour = texture2D( normalMap, v_vNormalTexcoord );
	vec3 normal = normalize((normalColour.rgb-0.5)*2.0);
	
	vec4 specular = texture2D( specularMap, v_vSpecularTexcoord );
	
	float pixelIllumination = max(-dot(normal, sunDirection), 0.0);
	
    gl_FragColor = vec4(normalColour.rgb, 1.0);
}
