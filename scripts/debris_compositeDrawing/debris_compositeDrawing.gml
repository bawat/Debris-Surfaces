function debris_compositeDrawing(rotation, diffuseLamda, normalLamda, specularLamda){
	var originalTranformMatrix = matrix_get(matrix_world);
	
	var transformMatrix = originalTranformMatrix;
	transformMatrix[0] = cos(rotation); transformMatrix[1] = -sin(rotation);
	transformMatrix[4] = sin(rotation); transformMatrix[5] = cos(rotation);
	
	transformMatrix[12] += x; transformMatrix[13] += y; transformMatrix[14] += 0;
	
	matrix_set(matrix_world, transformMatrix);
	
	if(isBeingDrawnToDebrisSurface_Normals()){
		//Normal vectors just straight up rotated won't point in the right directions.
		//Using a shader to repoint them when drawing to the surface.
		shader_set(IGNORE_sh_RotateNormalMap);
		var uniform = shader_get_uniform(IGNORE_sh_RotateNormalMap, "u_Rotation")
		shader_set_uniform_f(uniform, rotation);
		normalLamda();
		shader_reset()
	}else if(isBeingDrawnToDebrisSurface_Specular()){
		specularLamda();
	}else{
		diffuseLamda();
	}
	
	matrix_set(matrix_world, originalTranformMatrix);
}