/// @author Bawat (bawat@hotmail.co.uk)
/// @description Places a surface into the DebrisSurface
/// @param val1 The surface to draw into the DebrisSurface
/// @param val2 The x co-ordinate to draw this surface at
/// @param val3 The y co-ordinate to draw this surface at
/// @param val4 The alpha to draw this surface
/// @param val5 OPTIONAL The xscale to draw this surface
/// @param val6 OPTIONAL The yscale to draw this surface
function debris_add_surface() {

	var surf = argument[0];
	var xp = argument[1];
	var yp = argument[2];
	var alpha = argument[3];

	var scalex = 1;
	var scaley = 1;

	if(argument_count > 4){
		scalex = argument[4];
		scaley = argument[5];
	}

	/*
	 * As the debris map is actually a bunch of smaller surfaces next to each other
	 * I need to draw the thing to all 4 closest regions to prevent the drawing being
	 * cut off at the edges of the region.
	*/
	var surroundingSurfaces = debris_surface_get_surrounding_region_indexes(xp, yp);
	for(var i = 0; i < array_length_1d(surroundingSurfaces); i++){
		var regionID = surroundingSurfaces[i];
		debris_surface_set_region(regionID);
		var region = global.debris_surface_regions[regionID];
			draw_surface_ext(surf, xp - region[region_xStart], yp - region[region_yStart], scalex,scaley,0,c_white,alpha);
		debris_surface_reset_region();
	}



}
