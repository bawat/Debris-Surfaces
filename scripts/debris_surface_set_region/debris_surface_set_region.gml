/// @author Bawat (bawat@hotmail.co.uk)
/// @description Prepares the GPU for writing to this specific region
/// @param val1 regionID
function debris_surface_set_region(argument0) {

	var regionIndex = argument0;
	var region = global.debris_surface_regions[@ regionIndex];
	if (!surface_exists(region[region_surface])) {
	   region[@ region_surface] = debris_surface_create_surface_for_region(region);
	}
	surface_set_target(region[region_surface]);
	gpu_set_colorwriteenable(true, true, true, false);//Turn alpha drawing off - otherwise the transparency won't be mixed correctly


}
