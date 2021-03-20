/// @author Bawat (bawat@hotmail.co.uk)
/// @description Used to draw the debris placed inside the surface
function debris_draw() {

	var cam = view_camera[0];
	var camX = camera_get_view_x(cam);
	var camY = camera_get_view_y(cam);
	var camWidth = camera_get_view_width(cam);
	var camHeight = camera_get_view_height(cam);

	debugHoveredRegionXStart = 0;
	debugHoveredRegionYStart = 0;
	debugHoveredRegionXEnd = 0;
	debugHoveredRegionYEnd = 0;


	forEach(global.all_debris_surface_regions, function(existingRegion){
		if(IGNORE_regionOnScreen(existingRegion)){
			//Draw a green background behind any badly loaded Debris Surfaces
			draw_rectangle_color(existingRegion.xStart, existingRegion.yStart, existingRegion.xEnd, existingRegion.yEnd, c_green,c_green,c_green,c_green, false);
			
			if(!surface_exists(existingRegion.surface)){
				existingRegion.surface = IGNORE_debris_surface_create_diffuse_surface_for_region(existingRegion);
			}
			draw_surface(existingRegion.surface, existingRegion.xStart, existingRegion.yStart);
		
			//Setup for drawing a rectangle around the hovered-over region to show that the map is actually made up of small regions
			if(existingRegion.xStart < mouse_x && mouse_x < existingRegion.xEnd && existingRegion.yStart < mouse_y && mouse_y < existingRegion.yEnd){
				debugHoveredRegionXStart = existingRegion.xStart;
				debugHoveredRegionYStart = existingRegion.yStart;
				debugHoveredRegionXEnd = existingRegion.xEnd;
				debugHoveredRegionYEnd = existingRegion.yEnd;
			}
		}
	});

	//Draw a rectangle around the hovered-over region to show that the map is actually made up of small regions
	if(show_segment_outline){
		draw_rectangle_color(debugHoveredRegionXStart, debugHoveredRegionYStart, debugHoveredRegionXEnd, debugHoveredRegionYEnd, c_blue,c_blue,c_blue,c_blue, true);
	}

	//Load all on-screen chunks into regions we can use
	//a little hacky - but samples both onscreen and slightly offscreen coordinates to generate a surface at each region
	var loopStartX = camX - region_width;
	var loopStartY = camY - region_height;
	var loopEndX = camX + camWidth + region_width;
	var loopEndY = camY + camHeight + region_height;
	var loopIncrease = region_width;

	for(var yp = loopStartY; yp < loopEndY; yp += loopIncrease){
		for(var xp = loopStartX; xp < loopEndX; xp += loopIncrease){
			IGNORE_debris_surface_provide_region(xp, yp);
		}
	}


}
