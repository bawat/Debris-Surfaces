/// @author Bawat (bawat@hotmail.co.uk)
/// @description Places a surface into the DebrisSurface
/// @param val1 The surface to draw into the DebrisSurface
/// @param val2 The x co-ordinate to draw this surface at
/// @param val3 The y co-ordinate to draw this surface at
/// @param val4 The alpha to draw this surface
/// @param val5 OPTIONAL The xscale to draw this surface
/// @param val6 OPTIONAL The yscale to draw this surface
function debris_add_surface() {

	surf = argument[0];
	xp = argument[1];
	yp = argument[2];
	alpha = argument[3];

	scalex = 1;
	scaley = 1;

	if(argument_count > 4){
		scalex = argument[4];
		scaley = argument[5];
	}
	
	var longestLength = sqrt(power(surface_get_width(surf),2)  + power(surface_get_height(surf),2));

	/*
	 * As the debris map is actually a bunch of smaller surfaces next to each other
	 * I need to draw the thing to all 4 closest regions to prevent the drawing being
	 * cut off at the edges of the region.
	*/
	forEach(IGNORE_debris_surface_get_surrounding_regions(xp, yp, longestLength/2), function(region){
		IGNORE_debris_surface_set_region(region);
			draw_surface_ext(surf, xp - region.xStart, yp - region.yStart, scalex,scaley,0,c_white,alpha);
		IGNORE_debris_surface_reset_region();
	});
}
