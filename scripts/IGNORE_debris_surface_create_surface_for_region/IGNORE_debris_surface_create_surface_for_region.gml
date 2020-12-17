/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates a surface with the dimensions of a passed in regionID
/// @param val1 regionID
function IGNORE_debris_surface_create_surface_for_region(region) {
	return surface_create(region.xEnd-region.xStart, region.yEnd-region.yStart);
}
