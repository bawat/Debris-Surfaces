/// @author Bawat (bawat@hotmail.co.uk)
/// @description For an object, attempts to draw itself into the debris map
function debris_add_this() {

	var surroundingSurfaces = debris_surface_get_surrounding_region_indexes(x, y);
	for(var i = 0; i < array_length_1d(surroundingSurfaces); i++){
		var regionID = surroundingSurfaces[i];
		debris_surface_set_region(regionID);
			var region = global.debris_surface_regions[regionID];
		
			var transformMatrix = matrix_build_identity();
			transformMatrix[12] = -region[region_xStart];
			transformMatrix[13] = -region[region_yStart];
			transformMatrix[14] = 0;
	
			global.debris_isBeingDrawnToDebrisSurface = true;//This flag should be used to section out any code inside Draw that doesn't need to be placed into the Debris Map
			matrix_set(matrix_world, transformMatrix);

				//Call the object that called us' draw method.
				event_perform(ev_draw, 0);

			matrix_set(matrix_world, matrix_build_identity());
			global.debris_isBeingDrawnToDebrisSurface = false;
		debris_surface_reset_region();
	}


}
