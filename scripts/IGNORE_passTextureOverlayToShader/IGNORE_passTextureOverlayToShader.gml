// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function IGNORE_shaderOverlayTexture(shader, originTexture, sampler2DName, overlayTexture){
	var textureUniform = shader_get_sampler_index(shader, sampler2DName);
	texture_set_stage(textureUniform, overlayTexture);
	var UVWRemappingUniform = shader_get_uniform(shader,sampler2DName + "UVWRemappingTransform");
	shader_set_uniform_f_array(UVWRemappingUniform, calculateUVWRemappingDataWithTextures(originTexture, overlayTexture));
}
function IGNORE_calculateUVWRemappingDataWithTextures(argument0, argument1) {

	var diffuseMapUVW = texture_get_uvs(argument0);
	var normalMapUVW = texture_get_uvs(argument1);
	
	#macro left 0
	#macro right 2
	#macro top 1
	#macro bottom 3

	var URemapDelta = normalMapUVW[left] - diffuseMapUVW[left];
	var URemapScale = (normalMapUVW[right] - normalMapUVW[left])/(diffuseMapUVW[right] - diffuseMapUVW[left])

	var VRemapDelta = normalMapUVW[top] - diffuseMapUVW[top];
	var VRemapScale = (normalMapUVW[bottom] - normalMapUVW[top])/(diffuseMapUVW[bottom] - diffuseMapUVW[top])


	var arr = 0;
	arr[0] = URemapDelta;
	arr[1] = URemapScale;
	arr[2] = VRemapDelta;
	arr[3] = VRemapScale;

	return arr;
}