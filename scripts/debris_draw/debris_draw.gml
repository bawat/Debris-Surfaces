/// @author Bawat (bawat@hotmail.co.uk)
/// @description Used to draw the debris placed inside the surface
function debris_draw() {

	var cam = view_camera[0];
	var camX = camera_get_view_x(cam);
	var camY = camera_get_view_y(cam);
	var camWidth = camera_get_view_width(cam);
	var camHeight = camera_get_view_height(cam);

	var debugHoveredRegionXStart = 0;
	var debugHoveredRegionYStart = 0;
	var debugHoveredRegionXEnd = 0;
	var debugHoveredRegionYEnd = 0;

	var numberOfRegions = array_length_1d(global.debris_surface_regions);
	for(var i = 0; i < numberOfRegions; i++){
		var existingRegion = global.debris_surface_regions[@ i];
		if(!surface_exists(existingRegion[region_surface])){
			existingRegion[@ region_surface] = debris_surface_create_surface_for_region(existingRegion);
		}
	
		if(	isOnScreen(existingRegion[region_xStart], existingRegion[region_yStart]) ||
			isOnScreen(existingRegion[region_xStart] + region_width, existingRegion[region_yStart]) ||
			isOnScreen(existingRegion[region_xStart], existingRegion[region_yStart] + region_height) ||
			isOnScreen(existingRegion[region_xStart] + region_width, existingRegion[region_yStart] + region_height)
		){
			//Draw a green background behind any badly loaded Debris Surfaces
			draw_rectangle_color(existingRegion[region_xStart], existingRegion[region_yStart], existingRegion[region_xEnd], existingRegion[region_yEnd], c_green,c_green,c_green,c_green, false);
			draw_surface(existingRegion[region_surface], existingRegion[region_xStart], existingRegion[region_yStart]);
		
			//Draw a rectangle around the hovered-over region to show that the map is actually made up of small regions
			if(existingRegion[region_xStart] < mouse_x && mouse_x < existingRegion[region_xEnd] && existingRegion[region_yStart] < mouse_y && mouse_y < existingRegion[region_yEnd]){
				debugHoveredRegionXStart = existingRegion[region_xStart];
				debugHoveredRegionYStart = existingRegion[region_yStart];
				debugHoveredRegionXEnd = existingRegion[region_xEnd];
				debugHoveredRegionYEnd = existingRegion[region_yEnd];
			}
		}
	}

	//Draw a rectangle around the hovered-over region to show that the map is actually made up of small regions
	draw_rectangle_color(debugHoveredRegionXStart, debugHoveredRegionYStart, debugHoveredRegionXEnd, debugHoveredRegionYEnd, c_blue,c_blue,c_blue,c_blue, true);

	//We need to delay the usage of the backdrop until the backdrop layer has fully loaded
	if(!variable_global_exists("debris_begin_loadtime")){
		global.debris_begin_loadtime = current_time + 250;
	}else if(global.debris_begin_loadtime == 0){
		global.debris_begin_loadtime = current_time + 250;
	}
	if(current_time < global.debris_begin_loadtime) return;

	//Load on-screen chunks into surfaces we can use
	//a little hacky - but samples both onscreen and slightly offscreen coordinates to generate a surface at each region
	var loopStartX = camX - region_width;
	var loopStartY = camY - region_height;
	var loopEndX = camX + camWidth + region_width;
	var loopEndY = camY + camHeight + region_height;
	var loopIncrease = region_width;

	for(var yp = loopStartY; yp < loopEndY; yp += loopIncrease){
		for(var xp = loopStartX; xp < loopEndX; xp += loopIncrease){
			debris_surface_provide_region(xp, yp);
		}
	}


}
