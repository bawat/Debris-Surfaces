/// @author Bawat (bawat@hotmail.co.uk)
/// @description Initialises the DebrisSurface code
/// @param val1 The name of the sprite that will be used as the backdrop for the debris.
///				A backdrop is needed since surfaces can't hold transparency like Photoshop layers.
function debris_surface_backdrop_assign(debris_backdrop_sprite) {

	global.debris_backdrop_sprite = debris_backdrop_sprite;

	if(!variable_global_exists("all_debris_surface_regions")){
		global.all_debris_surface_regions = array_create(0);
	}
}