/// @author Bawat (bawat@hotmail.co.uk)
/// @description Frees all memory and sets the Debris Surface into a state where it can be used again.
function debris_backdrop_unassign() {
	forEach(global.all_debris_surface_regions, function(existingRegion){
		surface_free(existingRegion.surface);
		if(variable_struct_exists(existingRegion, "surface_normal")){
			surface_free(existingRegion.surface_normal);
		}
		if(variable_struct_exists(existingRegion, "surface_specular")){
			surface_free(existingRegion.surface_specular);
		}
	});
	global.all_debris_surface_regions = 0;
}
