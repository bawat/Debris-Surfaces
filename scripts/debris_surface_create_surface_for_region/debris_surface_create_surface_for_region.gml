/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates a surface with the dimensions of a passed in regionID
/// @param val1 regionID
function debris_surface_create_surface_for_region(argument0) {
	var region = argument0;
	return surface_create(region[region_xEnd]-region[region_xStart], region[region_yEnd]-region[region_yStart]);


}
