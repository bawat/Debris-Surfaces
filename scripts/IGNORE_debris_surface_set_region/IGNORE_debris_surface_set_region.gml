/// @author Bawat (bawat@hotmail.co.uk)
/// @description Prepares the GPU for writing to this specific region
/// @param val1 regionID
function IGNORE_debris_surface_set_region(region) {

	if (!surface_exists(region.surface)) {
	   region.surface = IGNORE_debris_surface_create_surface_for_region(region);
	}
	surface_set_target(region.surface);
	gpu_set_colorwriteenable(true, true, true, false);//Turn alpha drawing off - otherwise the transparency won't be mixed correctly
}
