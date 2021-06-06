// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function IGNORE_drawTransformAbsolute(px, py, rot, toDraw){
	var originalTranformMatrix = matrix_get(matrix_world);
	
	var transformMatrix = originalTranformMatrix;
	transformMatrix[0] = cos(rot); transformMatrix[1] = -sin(rot);
	transformMatrix[4] = sin(rot); transformMatrix[5] = cos(rot);
	
	transformMatrix[12] = px; transformMatrix[13] = py; transformMatrix[14] = rot;
	
	matrix_set(matrix_world, transformMatrix);
	toDraw();
	matrix_set(matrix_world, originalTranformMatrix);
}
function IGNORE_drawTransformRelative(dx, dy, dRot, toDraw){
	var originalTranformMatrix = matrix_get(matrix_world);
	
	var transformMatrix = originalTranformMatrix;
	transformMatrix[0] = cos(dRot); transformMatrix[1] = -sin(dRot);
	transformMatrix[4] = sin(dRot); transformMatrix[5] = cos(dRot);
	
	transformMatrix[12] = dx; transformMatrix[13] = dy; transformMatrix[14] = dRot;
	
	matrix_set(matrix_world, transformMatrix);
	toDraw();
	matrix_set(matrix_world, originalTranformMatrix);
}