/// @author Bawat (bawat@hotmail.co.uk)
/// @description Initialises the DebrisSurface code
/// @param val1 The name of the Layer that will be used as the backdrop for the debris.
///				A backdrop is needed since surfaces can't hold transparency like photoshop layers.
function debris_surface_backdrop_assign(debris_backdrop_layerName) {

	global.debris_backdrop_layerName = debris_backdrop_layerName;

	if(!variable_global_exists("all_debris_surface_regions")){
		global.all_debris_surface_regions = array_create(0);
	}

	var lay_id = layer_get_id(global.debris_backdrop_layerName);

	//Layers don't have a draw event we can call, so we must capture it by assigning it a surface
	//when it starts to run and closing the surface when it has finished running.
	layer_script_begin(lay_id, IGNORE_debris_surface_set_layer_backdrop_target);
	layer_script_end(lay_id, IGNORE_debris_surface_remove_layer_backdrop_target);
}
