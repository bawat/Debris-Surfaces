/// @author Bawat (bawat@hotmail.co.uk)
/// @description Frees all memory and sets the Debris Surface into a state where it can be used again.
function debris_surface_free() {
	forEach(global.all_debris_surface_regions, function(existingRegion){
		surface_free(existingRegion.surface);
		surface_free(existingRegion.surface_normal);
		surface_free(existingRegion.surface_specular);
	});
	global.all_debris_surface_regions = 0;
}
