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

	xp = argument[0];
	yp = argument[1];
	
	alpha = 1; alpha = argument[2];
	scalex = 1; scalex = argument[3];
	scaley = 1; scaley = argument[4];
	
	surfDiffuse = argument[5];
	surfNormal = argument[6];
	surfSpecular = argument[7];
	
	if(argument_count <= 5) {show_error("Not enough arguments supplied to debris_add_surface()", true);}
	
	var longestLength = sqrt(power(surface_get_width(surfDiffuse),2)  + power(surface_get_height(surfDiffuse),2));

	/*
	 * As the debris map is actually a bunch of smaller surfaces next to each other
	 * I need to draw the thing to all the surrounding regions to prevent the drawing being
	 * cut off at the edges of the region.
	*/
	forEach(IGNORE_debris_surface_get_surrounding_regions(xp, yp, longestLength/2), function(region){
		if(argument_count == 5){
			IGNORE_debris_surface_drawTo_region(region,
				function(){ draw_surface_ext(surfDiffuse, xp - region.xStart, yp - region.yStart, scalex,scaley,0,c_white,alpha); }
			);
		}
		if(argument_count == 6){
			IGNORE_debris_surface_drawTo_region(region,
				function(){ draw_surface_ext(surfDiffuse, xp - region.xStart, yp - region.yStart, scalex,scaley,0,c_white,alpha); },
				function(){ draw_surface_ext(surfNormal, xp - region.xStart, yp - region.yStart, scalex,scaley,0,c_white,1); },
			);
		}
		if(argument_count == 7){
			IGNORE_debris_surface_drawTo_region(region,
				function(){ draw_surface_ext(surfDiffuse, xp - region.xStart, yp - region.yStart, scalex,scaley,0,c_white,alpha); },
				function(){ draw_surface_ext(surfNormal, xp - region.xStart, yp - region.yStart, scalex,scaley,0,c_white,1); },
				function(){ draw_surface_ext(surfSpecular, xp - region.xStart, yp - region.yStart, scalex,scaley,0,c_white,1); },
			);
		}
		
	});
}
