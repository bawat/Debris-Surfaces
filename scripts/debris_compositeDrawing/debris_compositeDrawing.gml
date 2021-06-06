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
		
		surfaceRadius = 64;
		
		var toDrawDiffuseSurface = IGNORE_draw_to_surface(diffuseLamda, rotation, surfaceRadius);
		var toDrawNormalSurface = IGNORE_draw_to_surface(normalLamda, rotation, surfaceRadius);
		var toDrawSpecularSurface = IGNORE_draw_to_surface(specularLamda, rotation, surfaceRadius);
		
		var toDrawDiffuseTexture = surface_get_texture(toDrawDiffuseSurface);
		
		var region = IGNORE_debris_surface_provide_region(x, y);
		var localRegionX = x - region.xStart;//Needed?
		var localRegionY = y - region.yStart;//Needed?
		
		/*
			* Place the normals from the surrounding regions into a texture that we will pass to the GPU.
			* Can't just used the UVWs of the surface you're on, because at the edges there's junk data.
			* Basically, impossible as the old method won't work at the seams.
		*/
		if(!variable_instance_exists(id, "debrisTempNormalsSurface") || !surface_exists(debrisTempNormalsSurface) || surface_get_height(debrisTempNormalsSurface) != surfaceRadius*2)
			debrisTempNormalsSurface = surface_create(surfaceRadius*2, surfaceRadius*2);
		
		IGNORE_drawTransformAbsolute(surfaceRadius-x, surfaceRadius-y, 0, function(){
			surface_set_target(debrisTempNormalsSurface);
			
			forEach(IGNORE_debris_surface_get_surrounding_regions(x, y, surfaceRadius), function(region){
				draw_surface_stretched(region.surface_normal, region.xStart, region.yStart, region.xEnd-region.xStart, region.yEnd-region.yStart);
			});
			
			surface_reset_target();
		});
		surface_get_texture(debrisTempNormalsSurface);
		
		shader_set(GetBackdropNormals);

			IGNORE_shaderOverlayTexture(GetBackdropNormals, toDrawDiffuseTexture, "debrisNormalMap", surface_get_texture(debrisTempNormalsSurface));
			IGNORE_shaderOverlayTexture(GetBackdropNormals, toDrawDiffuseTexture, "toDrawNormalMap", surface_get_texture(toDrawNormalSurface));
			IGNORE_shaderOverlayTexture(GetBackdropNormals, toDrawDiffuseTexture, "toDrawSpecularMap", surface_get_texture(toDrawSpecularSurface));
				
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