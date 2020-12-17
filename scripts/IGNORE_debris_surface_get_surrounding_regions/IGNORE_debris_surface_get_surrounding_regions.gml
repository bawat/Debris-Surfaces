/// @author Bawat (bawat@hotmail.co.uk)
/// @description Returns the 4 closest regions to where something is. This is used by the draw script to
///				 make sure when we draw something on an edge, it is drawn to all surfaces and isn't cut off.
/// @param val1 The x co-ordinate to find the 4 closest regions from
/// @param val2 The y co-ordinate to find the 4 closest regions from
/// @param val3 The radius of the area expected to be taken up by the drawing
function IGNORE_debris_surface_get_surrounding_regions(xp, yp, radius) {

	var lowestPossibleXValue = xp - radius;
	var lowestPossibleYValue = yp - radius;
	var highestPossibleXValue = xp + radius;
	var highestPossibleYValue = yp + radius;
	
	var arrayIndex = 0;
	var modifiedRegions = 0;
	for(var xvar = lowestPossibleXValue; xvar < highestPossibleXValue + region_width; xvar += region_width){
		for(var yvar = lowestPossibleYValue; yvar < highestPossibleYValue + region_height; yvar += region_height){
			modifiedRegions[arrayIndex++] = IGNORE_debris_surface_provide_region(xvar, yvar);
		}
	}

	return modifiedRegions;
}
