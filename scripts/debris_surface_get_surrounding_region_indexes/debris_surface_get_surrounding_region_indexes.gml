/// @author Bawat (bawat@hotmail.co.uk)
/// @description Returns the 4 closest regions to where something is. This is used by the draw script to
///				 make sure when we draw something on an edge, it is drawn to all surfaces and isn't cut off.
/// @param val1 The x co-ordinate to find the 4 closest regions from
/// @param val2 The y co-ordinate to find the 4 closest regions from
function debris_surface_get_surrounding_region_indexes(argument0, argument1) {

	var xp = argument0;
	var yp = argument1;

	var posX = round(xp/region_width)*region_width;
	var posY = round(yp/region_height)*region_height;

	var surroundingIndexes = 0;
	surroundingIndexes[0] = debris_surface_provide_region(posX + 1, posY + 1);
	surroundingIndexes[1] = debris_surface_provide_region(posX + 1, posY - 1);
	surroundingIndexes[2] = debris_surface_provide_region(posX - 1, posY + 1);
	surroundingIndexes[3] = debris_surface_provide_region(posX - 1, posY - 1);

	return surroundingIndexes;


}
