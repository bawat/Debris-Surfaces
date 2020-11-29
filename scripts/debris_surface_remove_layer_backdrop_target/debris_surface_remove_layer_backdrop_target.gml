/// @author Bawat (bawat@hotmail.co.uk)
/// @description Cleanup after having drawn the backdrop layer's correct portion into a newly created surface
function debris_surface_remove_layer_backdrop_target() {
	if(event_type != ev_draw || event_number != 0 || global.debris_backdrop_regionTarget = -1) return;

	//Let the region know it is now officially initialised
	var region = global.debris_surface_regions[@ global.debris_backdrop_regionTarget];
	region[@ region_initialised] = true;

	//Shift the layer back to it's original position - this was required to draw the correct portion to the surface
	var layerID = layer_get_id(global.debris_backdrop_layerName);
	layer_x(layerID, 0);
	layer_y(layerID, 0);

	surface_reset_target();


}
