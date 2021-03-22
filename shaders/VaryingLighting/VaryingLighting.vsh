//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
//attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
uniform vec4 UVWremappingTransform;

varying vec2 v_vTextureCoord;
varying vec2 v_vNormalTexcoord;
varying vec2 v_vSpecularTexcoord;
//varying vec4 v_vColour;

void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    //v_vColour = in_Colour;
    v_vTextureCoord = in_TextureCoord;
	
	float URemapDelta = UVWremappingTransform[0];
	float URemapScale = UVWremappingTransform[1];
	float VRemapDelta = UVWremappingTransform[2];
	float VRemapScale = UVWremappingTransform[3];
	v_vNormalTexcoord = vec2(URemapDelta + in_TextureCoord.x*URemapScale,  VRemapDelta + in_TextureCoord.y*VRemapScale);
}