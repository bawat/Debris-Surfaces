/// @author Bawat (bawat@hotmail.co.uk)
/// @description Initialises the DebrisSurface code
/// @param val1 The name of the sprite that will be used as the backdrop for the debris.
///				A backdrop is needed since surfaces can't hold transparency like Photoshop layers.
function debris_backdrop_assign(debris_backdrop_default_sprite_diffuse) {
	var debris_backdrop_default_sprite_normals = pointer_null; if(argument_count > 1) { debris_backdrop_default_sprite_normals = argument[1]; }
	var debris_backdrop_default_sprite_specular = pointer_null; if(argument_count > 2) { debris_backdrop_default_sprite_normals = argument[2]; }
	
	
	global.debris_backdrop_default_sprite = {
		diffuse : debris_backdrop_default_sprite_diffuse,
		specular : debris_backdrop_default_sprite_normals,
		normal : debris_backdrop_default_sprite_specular
	};

	if(!variable_global_exists("all_debris_surface_regions")){
		global.all_debris_surface_regions = array_create(0);
	}
}