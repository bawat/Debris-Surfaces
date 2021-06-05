//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
//attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
uniform vec4 UVWDebrisNormalRemappingTransform;
uniform vec4 UVWToDrawNormalRemappingTransform;
uniform vec4 UVWToDrawSpecularRemappingTransform;

varying vec2 v_vTextureCoord;
varying vec2 v_vNormalTexcoord;
varying vec2 v_vSpecularTexcoord;
varying vec2 v_vDebrisNormalTexcoord;

varying vec4 v_Position;
//varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    //v_vColour = in_Colour;
    v_vTextureCoord = in_TextureCoord;
	
	
	float DebrisNormalURemapDelta = UVWDebrisNormalRemappingTransform[0];
	float DebrisNormalURemapScale = UVWDebrisNormalRemappingTransform[1];
	float DebrisNormalVRemapDelta = UVWDebrisNormalRemappingTransform[2];
	float DebrisNormalVRemapScale = UVWDebrisNormalRemappingTransform[3];
	v_vDebrisNormalTexcoord = vec2(DebrisNormalURemapDelta + in_TextureCoord.x*DebrisNormalURemapScale,  DebrisNormalVRemapDelta + in_TextureCoord.y*DebrisNormalVRemapScale);
	
	float NormalURemapDelta = UVWToDrawNormalRemappingTransform[0];
	float NormalURemapScale = UVWToDrawNormalRemappingTransform[1];
	float NormalVRemapDelta = UVWToDrawNormalRemappingTransform[2];
	float NormalVRemapScale = UVWToDrawNormalRemappingTransform[3];
	v_vNormalTexcoord = vec2(NormalURemapDelta + in_TextureCoord.x*NormalURemapScale,  NormalVRemapDelta + in_TextureCoord.y*NormalVRemapScale);
	
	float SpecularURemapDelta = UVWToDrawSpecularRemappingTransform[0];
	float SpecularURemapScale = UVWToDrawSpecularRemappingTransform[1];
	float SpecularVRemapDelta = UVWToDrawSpecularRemappingTransform[2];
	float SpecularVRemapScale = UVWToDrawSpecularRemappingTransform[3];
	v_vSpecularTexcoord = vec2(SpecularURemapDelta + in_TextureCoord.x*SpecularURemapScale,  SpecularVRemapDelta + in_TextureCoord.y*SpecularVRemapScale);
	v_Position = gl_Position;
}