function debris_compositeDrawing(rotation, diffuseLamda, normalLamda, specularLamda){
	var originalTranformMatrix = matrix_get(matrix_world);
	
	var transformMatrix = originalTranformMatrix;
	transformMatrix[0] = cos(rotation); transformMatrix[1] = -sin(rotation);
	transformMatrix[4] = sin(rotation); transformMatrix[5] = cos(rotation);
	
	transformMatrix[12] += x; transformMatrix[13] += y; transformMatrix[14] += 0;
	
	matrix_set(matrix_world, transformMatrix);
	
	if(!isBeingDrawnToDebrisSurface()){
		var region = IGNORE_debris_surface_provide_region(x, y);
		
		var localRegionX = x - region.xStart;
		var localRegionY = y - region.yStart;
		
		var diffuseMapTexture = surface_get_texture(region.surface);
		var normalMapTexture = surface_get_texture(region.surface_normal);
		var specularMapTexture = surface_get_texture(region.surface_specular);
		
		//Use a shader so that transparent 
		shader_set(VaryingLighting);
		
			var normalMapUniform = shader_get_sampler_index(VaryingLighting,"normalMap");
			var normalMapTexture = surface_get_texture(region.surface_normal);
			texture_set_stage(normalMapUniform, normalMapTexture);
					
			var UVWremappingTransformUniform = shader_get_uniform(VaryingLighting,"UVWNormalRemappingTransform");
			shader_set_uniform_f_array(UVWremappingTransformUniform, calculateUVWRemappingDataWithTextures(diffuseMapTexture, normalMapTexture));

			var specularMapUniform = shader_get_sampler_index(VaryingLighting,"specularMap");
			var specularMapTexture = surface_get_texture(region.surface_specular);
			texture_set_stage(specularMapUniform, specularMapTexture);
					
			var UVWremappingTransformUniform = shader_get_uniform(VaryingLighting,"UVWSpecularRemappingTransform");
			shader_set_uniform_f_array(UVWremappingTransformUniform, calculateUVWRemappingDataWithTextures(diffuseMapTexture, specularMapTexture));
				
			time = shader_get_uniform(VaryingLighting,"uTime");
			shader_set_uniform_f(time, current_time/1000);
			
			diffuseLamda();
			
		shader_reset();
	}else if(isBeingDrawnToDebrisSurface_Normals()){
		//Normal vectors just straight up rotated won't point in the right directions.
		//Using a shader to repoint them when drawing to the surface.
		shader_set(IGNORE_sh_RotateNormalMap);
		var uniform = shader_get_uniform(IGNORE_sh_RotateNormalMap, "u_Rotation")
		shader_set_uniform_f(uniform, rotation);
		normalLamda();
		shader_reset()
	}else if(isBeingDrawnToDebrisSurface_Specular()){
		specularLamda();
	}else if(isBeingDrawnToDebrisSurface_Diffuse()){
		diffuseLamda();
	}
	
	matrix_set(matrix_world, originalTranformMatrix);
}