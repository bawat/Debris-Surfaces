/// @author Bawat (bawat@hotmail.co.uk)
/// @description Used to draw the backdrop layer's correct section into a newly created surface
function debris_surface_set_layer_backdrop_target() {
	if(event_type != ev_draw || event_number != 0) return;

	//Find any newly created regions that don't yet have a backdrop
	var toInitialise = -1;
	for(var i = 0; i < array_length_1d(global.debris_surface_regions); i++){
		var region = global.debris_surface_regions[i];
		if(!region[region_initialised]){
			toInitialise = i;
		}
	}

	//Using global variables since if we surface_set_target, we will need to surface_reset_target in the remove script later
	global.debris_backdrop_regionTarget = toInitialise;
	global.debris_isBeingDrawnToDebrisSurface = false;

	if(toInitialise != -1){
		//Prepare the surface target for the layer to be drawn to
		var region = global.debris_surface_regions[@ toInitialise];
		if(!surface_exists(region[region_surface])){
			region[@ region_surface] = debris_surface_create_surface_for_region(region);
		}
		surface_set_target(region[region_surface]);
	
		//Shift the layer to draw the correct portion of the layer to the surface
		var layerID = layer_get_id(global.debris_backdrop_layerName);
		layer_x(layerID, -region[region_xStart]);
		layer_y(layerID, -region[region_yStart]);
	}


}
