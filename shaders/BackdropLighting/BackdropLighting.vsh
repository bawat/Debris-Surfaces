//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
//attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
uniform vec4 UVWNormalRemappingTransform;
uniform vec4 UVWSpecularRemappingTransform;

varying vec2 v_vTextureCoord;
varying vec2 v_vNormalTexcoord;
varying vec2 v_vSpecularTexcoord;

varying vec4 v_Position;
//varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    //v_vColour = in_Colour;
    v_vTextureCoord = in_TextureCoord;
	
	float URemapDelta = UVWNormalRemappingTransform[0];
	float URemapScale = UVWNormalRemappingTransform[1];
	float VRemapDelta = UVWNormalRemappingTransform[2];
	float VRemapScale = UVWNormalRemappingTransform[3];
	v_vNormalTexcoord = vec2(URemapDelta + in_TextureCoord.x*URemapScale,  VRemapDelta + in_TextureCoord.y*VRemapScale);
	
	float SpecularURemapDelta = UVWSpecularRemappingTransform[0];
	float SpecularURemapScale = UVWSpecularRemappingTransform[1];
	float SpecularVRemapDelta = UVWSpecularRemappingTransform[2];
	float SpecularVRemapScale = UVWSpecularRemappingTransform[3];
	v_vSpecularTexcoord = vec2(SpecularURemapDelta + in_TextureCoord.x*SpecularURemapScale,  SpecularVRemapDelta + in_TextureCoord.y*SpecularVRemapScale);
	v_Position = gl_Position;
}