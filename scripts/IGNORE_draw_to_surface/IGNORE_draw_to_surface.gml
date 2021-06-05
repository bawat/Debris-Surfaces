// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function IGNORE_draw_to_surface(drawLambda, rotation, radius){
	var surface = surface_create(radius*2, radius*2);
	surface_set_target(surface);
	
	var originalTranformMatrix = matrix_get(matrix_world);
	var transformMatrix = originalTranformMatrix;
	transformMatrix[0] = cos(rotation); transformMatrix[1] = -sin(rotation);
	transformMatrix[4] = sin(rotation); transformMatrix[5] = cos(rotation);
	
	transformMatrix[12] = radius; transformMatrix[13] = radius; transformMatrix[14] = 0;
	
	matrix_set(matrix_world, transformMatrix);
	
	drawLambda();
	
	matrix_set(matrix_world, originalTranformMatrix);
	
	surface_reset_target();
	return surface;
}