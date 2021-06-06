/// @author Bawat (bawat@hotmail.co.uk)
/// @description Places a surface into the DebrisSurface
/// @param val1 The x co-ordinate to draw this surface at
/// @param val2 The y co-ordinate to draw this surface at
/// @param val3 The alpha to draw this surface
/// @param val4 The xscale to draw this surface
/// @param val5 The yscale to draw this surface
/// @param val6 The diffuse surface to draw into the DebrisSurface
/// @param val7 OPTIONAL The normals surface to draw into the DebrisSurface
/// @param val8 OPTIONAL The specular surface to draw into the DebrisSurface
function debris_add_surface() {
	arg_count = argument_count;
	if(arg_count < 5) {show_error("Not enough arguments supplied to debris_add_surface()", true);}
	debris_add_surface_xp = argument[0];
	debris_add_surface_yp = argument[1];
	
	alpha = 1; alpha = argument[2];
	scalex = 1; scalex = argument[3];
	scaley = 1; scaley = argument[4];
	
	surfDiffuse = argument[5];
	if(arg_count >= 7) {surfNormal = argument[6]};
	if(arg_count >= 8) {surfSpecular = argument[7]};
	
	var longestLength = sqrt(power(surface_get_width(surfDiffuse),2)  + power(surface_get_height(surfDiffuse),2));

	/*
	 * As the debris map is actually a bunch of smaller surfaces next to each other
	 * I need to draw the thing to all the surrounding regions to prevent the drawing being
	 * cut off at the edges of the region.
	*/
	forEach(IGNORE_debris_surface_get_surrounding_regions(debris_add_surface_xp, debris_add_surface_yp, longestLength/2), function(region){
		region_ = region;
		
		if(arg_count == 6){
			IGNORE_debris_surface_drawTo_region(region_,
				function(){ draw_surface_ext(surfDiffuse, debris_add_surface_xp - region_.xStart, debris_add_surface_yp - region_.yStart, scalex,scaley,0,c_white,alpha); }
			);
		}
		if(arg_count == 7){
			IGNORE_debris_surface_drawTo_region(region_,
				function(){ draw_surface_ext(surfDiffuse, debris_add_surface_xp - region_.xStart, debris_add_surface_yp - region_.yStart, scalex,scaley,0,c_white,alpha); },
				function(){ draw_surface_ext(surfNormal, debris_add_surface_xp - region_.xStart, debris_add_surface_yp - region_.yStart, scalex,scaley,0,c_white,1); },
			);
		}
		if(arg_count == 8){
			IGNORE_debris_surface_drawTo_region(region_,
				function(){ draw_surface_ext(surfDiffuse, debris_add_surface_xp - region_.xStart, debris_add_surface_yp - region_.yStart, scalex,scaley,0,c_white,alpha); },
				function(){ draw_surface_ext(surfNormal, debris_add_surface_xp - region_.xStart, debris_add_surface_yp - region_.yStart, scalex,scaley,0,c_white,1); },
				function(){ draw_surface_ext(surfSpecular, debris_add_surface_xp - region_.xStart, debris_add_surface_yp - region_.yStart, scalex,scaley,0,c_white,1); },
			);
		}
		
	});
}
