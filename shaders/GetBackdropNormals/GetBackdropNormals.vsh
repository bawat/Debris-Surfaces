//
// Simple passthrough vertex shader
//
attribute vec3 in_Position;                  // (x,y,z)
//attribute vec3 in_Normal;                  // (x,y,z)     unused in this shader.
//attribute vec4 in_Colour;                    // (r,g,b,a)
attribute vec2 in_TextureCoord;              // (u,v)
uniform vec4 debrisNormalMapUVWRemappingTransform;
uniform vec4 toDrawNormalMapUVWRemappingTransform;
uniform vec4 toDrawSpecularMapUVWRemappingTransform;

varying vec2 v_vTextureCoord;
varying vec2 v_vNormalTexcoord;
varying vec2 v_vSpecularTexcoord;
varying vec2 v_vDebrisNormalTexcoord;

varying vec4 v_Position;
//varying vec4 v_vColour;

vec2 UVWRemap(vec2 texCoord, vec4 transformData)
{
	float URemapDelta = transformData[0];
	float URemapScale = transformData[1];
	float VRemapDelta = transformData[2];
	float VRemapScale = transformData[3];
	return vec2(URemapDelta + texCoord.x*URemapScale, VRemapDelta + texCoord.y*VRemapScale);
}
void main()
{
    vec4 object_space_pos = vec4( in_Position.x, in_Position.y, in_Position.z, 1.0);
    gl_Position = gm_Matrices[MATRIX_WORLD_VIEW_PROJECTION] * object_space_pos;
    
    //v_vColour = in_Colour;
    v_vTextureCoord = in_TextureCoord;
	
	v_vDebrisNormalTexcoord = UVWRemap(in_TextureCoord, debrisNormalMapUVWRemappingTransform);
	v_vNormalTexcoord = UVWRemap(in_TextureCoord, toDrawNormalMapUVWRemappingTransform);
	v_vSpecularTexcoord = UVWRemap(in_TextureCoord, toDrawSpecularMapUVWRemappingTransform);
	
	v_Position = gl_Position;
}