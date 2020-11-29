/// @author Bawat (bawat@hotmail.co.uk)
/// @description Given an coordinate, this script is guaranteed to give you back a region for that coordinate. Even if it has to create one from scratch.
/// @param val1 The x co-ordinate to find the 4 region for
/// @param val2 The y co-ordinate to find the 4 region for
function debris_surface_provide_region(argument0, argument1) {
	var xp = argument0;
	var yp = argument1;

	//Check the existing regions to see if one of them contains the coordiante
	var numberOfRegions = array_length_1d(global.debris_surface_regions);
	for(var i = 0; i < numberOfRegions; i++){
		var existingRegion = global.debris_surface_regions[i];
		if(xp >= existingRegion[region_xStart] && xp < existingRegion[region_xEnd]){
			if(yp >= existingRegion[region_yStart] && yp < existingRegion[region_yEnd]){
				return i;
			}
		}
	}

	//If we reach this section of code, then no region for the coordinate has been found. Create one from scratch.
	var posX = floor(xp/region_width)*region_width;
	var posY = floor(yp/region_height)*region_height;
	return debris_surface_new_region(posX, posY, posX + region_width, posY + region_height);


}
