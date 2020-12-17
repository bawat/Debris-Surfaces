/// @author Bawat (bawat@hotmail.co.uk)
/// @description Given an coordinate, this script is guaranteed to give you back a region for that coordinate. Even if it has to create one from scratch.
/// @param val1 The x co-ordinate to find the 4 region for
/// @param val2 The y co-ordinate to find the 4 region for
function IGNORE_debris_surface_provide_region(argument0, argument1) {
	xp = argument0;
	yp = argument1;

	//Check the existing regions to see if one of them contains the coordiante
	locatedRegion = pointer_null;
	forEach(global.all_debris_surface_regions, function(element){
		if(xp >= element.xStart && xp < element.xEnd){
			if(yp >= element.yStart && yp < element.yEnd){
				locatedRegion = element;
			}
		}
	});
	if(locatedRegion != pointer_null){ return locatedRegion; }

	//If we reach this section of code, then no region for the coordinate has been found. Create one from scratch.
	var posX = floor(xp/region_width)*region_width;
	var posY = floor(yp/region_height)*region_height;
	return IGNORE_debris_surface_new_region(posX, posY, posX + region_width, posY + region_height);
}
