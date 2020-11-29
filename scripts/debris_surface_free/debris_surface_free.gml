/// @author Bawat (bawat@hotmail.co.uk)
/// @description Frees all memory and sets the Debris Surface into a state where it can be used again.
function debris_surface_free() {

	var numberOfRegions = array_length_1d(global.debris_surface_regions);
	for(var i = 0; i < numberOfRegions; i++){
		var existingRegion = global.debris_surface_regions[@ i];
		surface_free(existingRegion[region_surface]);
	}
	global.debris_surface_regions = 0;
	global.debris_begin_loadtime = 0;


}
