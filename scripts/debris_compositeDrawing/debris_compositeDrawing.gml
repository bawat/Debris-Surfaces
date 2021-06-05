function debris_compositeDrawing(rotation, diffuseLamda, normalLamda, percentOfNormalsFromBackground, specularLamda){
	var originalTranformMatrix = matrix_get(matrix_world);
	
	var transformMatrix = originalTranformMatrix;
	transformMatrix[0] = cos(rotation); transformMatrix[1] = -sin(rotation);
	transformMatrix[4] = sin(rotation); transformMatrix[5] = cos(rotation);
	
	transformMatrix[12] += x; transformMatrix[13] += y; transformMatrix[14] += 0;
	
	matrix_set(matrix_world, transformMatrix);
	
	if(!isBeingDrawnToDebrisSurface()){
		//When drawing transparent stuff normally, the normals of the debris surface aren't taken into consideration
		//Using a shader to get the normals and apply them to the image we want to draw
		
		var surfaceRadius = 64;
		
		var toDrawDiffuseSurface = IGNORE_draw_to_surface(diffuseLamda, rotation, surfaceRadius);
		var toDrawNormalSurface = IGNORE_draw_to_surface(normalLamda, rotation, surfaceRadius);
		var toDrawSpecularSurface = IGNORE_draw_to_surface(specularLamda, rotation, surfaceRadius);
		var toDrawDiffuseTexture = surface_get_texture(toDrawDiffuseSurface);
		
		var region = IGNORE_debris_surface_provide_region(x, y);
		var localRegionX = x - region.xStart;//Needed?
		var localRegionY = y - region.yStart;//Needed?
		
		shader_set(GetBackdropNormals);
		
			var regionNormalMapUniform = shader_get_sampler_index(GetBackdropNormals,"debrisNormalMap");
			var regionNormalMapTexture = surface_get_texture(region.surface_normal);
			texture_set_stage(regionNormalMapUniform, regionNormalMapTexture);
			var UVWDebrisNormalRemappingTransformUniform = shader_get_uniform(GetBackdropNormals,"UVWDebrisNormalRemappingTransform");
			
			//Find the UVs of the radius*2 x radius*2 region we need from this debris surface tile
			var localRegionXPercent = localRegionX/abs(region.xEnd - region.xStart);
			var localRegionYPercent = localRegionY/abs(region.yEnd - region.yStart);
			var localRegionCutoutWidthPercent = surfaceRadius*2/abs(region.xEnd - region.xStart);
			var localRegionCutoutHeightPercent = surfaceRadius*2/abs(region.yEnd - region.yStart);
			
			var UVWRemapping = calculateUVWRemappingDataWithTextures(toDrawDiffuseTexture, regionNormalMapTexture);
			UVWRemapping[0] += UVWRemapping[1] * localRegionXPercent;
			UVWRemapping[1] *= localRegionCutoutWidthPercent;
			UVWRemapping[2] += UVWRemapping[3] * localRegionYPercent;
			UVWRemapping[3] *= localRegionCutoutHeightPercent;
			
			var debrisNormalUVW = texture_get_uvs(regionNormalMapTexture);
			if(UVWRemapping[0] + UVWRemapping[1] > debrisNormalUVW[right])
				UVWRemapping[0] -= (debrisNormalUVW[right] - debrisNormalUVW[left])/2;
				
			if(UVWRemapping[2] + UVWRemapping[3] > debrisNormalUVW[bottom])
				UVWRemapping[2] -= (debrisNormalUVW[bottom] - debrisNormalUVW[top])/2;
			
			shader_set_uniform_f_array(UVWDebrisNormalRemappingTransformUniform, UVWRemapping);

			

			var toDrawNormalMapUniform = shader_get_sampler_index(GetBackdropNormals,"toDrawNormalMap");
			var toDrawNormalMapTexture = surface_get_texture(toDrawNormalSurface);
			texture_set_stage(toDrawNormalMapUniform, toDrawNormalMapTexture);
			var UVWToDrawNormalRemappingTransformUniform = shader_get_uniform(GetBackdropNormals,"UVWToDrawNormalRemappingTransform");
			shader_set_uniform_f_array(UVWToDrawNormalRemappingTransformUniform, calculateUVWRemappingDataWithTextures(toDrawDiffuseTexture, toDrawNormalMapTexture));

			var toDrawSpecularMapUniform = shader_get_sampler_index(GetBackdropNormals,"toDrawSpecularMap");
			var toDrawSpecularMapTexture = surface_get_texture(toDrawSpecularSurface);
			texture_set_stage(toDrawSpecularMapUniform, toDrawSpecularMapTexture);
			var UVWToDrawSpecularRemappingTransformUniform = shader_get_uniform(GetBackdropNormals,"UVWToDrawSpecularRemappingTransform");
			shader_set_uniform_f_array(UVWToDrawSpecularRemappingTransformUniform, calculateUVWRemappingDataWithTextures(toDrawDiffuseTexture, toDrawSpecularMapTexture));
				
			var time = shader_get_uniform(GetBackdropNormals,"uTime");
			shader_set_uniform_f(time, current_time/1000);
			
			var percentBackground = shader_get_uniform(GetBackdropNormals, "uPercentBackground");
			shader_set_uniform_f(percentBackground, percentOfNormalsFromBackground)
			
			draw_surface(toDrawDiffuseSurface, -surfaceRadius, -surfaceRadius);
			
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