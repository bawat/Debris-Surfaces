/// @author Bawat (bawat@hotmail.co.uk)
/// @description Frees all memory and sets the Debris Surface into a state where it can be used again.
function debris_surface_free() {
	forEach(global.all_debris_surface_regions, function(existingRegion){
		surface_free(existingRegion.surface);
	});
	global.all_debris_surface_regions = 0;
	global.debris_begin_loadtime = 0;
}
