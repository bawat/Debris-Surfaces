//
// Simple passthrough fragment shader
//
uniform float uTime;

varying vec2 v_vTextureCoord;
varying vec2 v_vNormalTexcoord;
varying vec2 v_vSpecularTexcoord;
varying vec4 v_Position;
uniform sampler2D normalMap;              // (u,v)
uniform sampler2D specularMap;              // (u,v)
//varying vec4 v_vColour;

void main()
{
	vec3 sunDirection = normalize(vec3(cos(uTime) , sin(uTime), -0.5));
	vec3 cameraLocation = vec3(0.5, 0.5, -1.0);
	float ambientLight = 1.3;
	
	vec4 diffuse = texture2D( gm_BaseTexture, v_vTextureCoord );
	vec4 normalColour = texture2D( normalMap, v_vNormalTexcoord );
	vec4 specularColour = texture2D( specularMap, v_vSpecularTexcoord );
	vec3 normal = normalize((normalColour.rgb-0.5)*2.0);
	
	vec3 pixelToCamera = normalize(cameraLocation - v_Position.xyz);
	
	float pixelPercentIllumination = max(dot(normal, -sunDirection), 0.0);
	
	vec3 sunReflection = normalize(sunDirection + 2.0*dot(-sunDirection,normal)*normal);
	float highlightIllumination = 1.0 + pow(dot(sunReflection,pixelToCamera), 4.0)*(specularColour.r/1.0);
	
    gl_FragColor = vec4(diffuse.rgb * pixelPercentIllumination * highlightIllumination, 1.0);
}
