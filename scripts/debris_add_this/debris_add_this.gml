/// @author Bawat (bawat@hotmail.co.uk)
/// @description For an object, attempts to draw itself into the debris map
/// @param radius Used to determine if drawing this sprite will overlap any region edges and resolve it
function debris_add_this(radius) {
	forEach(IGNORE_debris_surface_get_surrounding_regions(x, y, radius), function(surroundingRegion){
		var transformMatrix = matrix_build_identity();
			transformMatrix[12] = -surroundingRegion.xStart;
			transformMatrix[13] = -surroundingRegion.yStart;
			transformMatrix[14] = 0;
		
		global.debris_isBeingDrawnToDebrisSurface = true;//This flag should be used to section out any code inside Draw that doesn't need to be placed into the Debris Map
		matrix_set(matrix_world, transformMatrix);
		
		
		if(){
			IGNORE_debris_surface_drawTo_region(surroundingRegion,
				function(surroundingRegion){
						//Call the object that called us' draw method.
						event_perform(ev_draw, 0);
				},
				function(surroundingRegion){
						//Call the object that called us' draw method.
						event_perform(ev_draw, 0);
				},
				function(surroundingRegion){
						//Call the object that called us' draw method.
						event_perform(ev_draw, 0);
				});
		}
		
		matrix_set(matrix_world, matrix_build_identity());
		global.debris_isBeingDrawnToDebrisSurface = false;
	});
}