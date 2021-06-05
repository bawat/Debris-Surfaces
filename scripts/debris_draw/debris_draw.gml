/// @author Bawat (bawat@hotmail.co.uk)
/// @description Used to draw the debris placed inside the surface
function calculateUVWRemappingDataWithTextures(argument0, argument1) {

	var diffuseMapUVW = texture_get_uvs(argument0);
	var normalMapUVW = texture_get_uvs(argument1);
	
	#macro left 0
	#macro right 2
	#macro top 1
	#macro bottom 3

	var URemapDelta = normalMapUVW[left] - diffuseMapUVW[left];
	var URemapScale = (normalMapUVW[right] - normalMapUVW[left])/(diffuseMapUVW[right] - diffuseMapUVW[left])

	var VRemapDelta = normalMapUVW[top] - diffuseMapUVW[top];
	var VRemapScale = (normalMapUVW[bottom] - normalMapUVW[top])/(diffuseMapUVW[bottom] - diffuseMapUVW[top])


	var arr = 0;
	arr[0] = URemapDelta;
	arr[1] = URemapScale;
	arr[2] = VRemapDelta;
	arr[3] = VRemapScale;

	return arr;
}
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
			
			shader_set(BackdropLighting);
			
				var diffuseMapTexture = surface_get_texture(existingRegion.surface);
			
				if(number_of_texture_channels >= textures_diffuse_and_normals){
					if(!surface_exists(existingRegion.surface_normal)){
						existingRegion.surface_normal = IGNORE_debris_surface_create_normal_surface_for_region(existingRegion);
					}
				    var normalMapUniform = shader_get_sampler_index(BackdropLighting,"normalMap");
					var normalMapTexture = surface_get_texture(existingRegion.surface_normal);
					texture_set_stage(normalMapUniform, normalMapTexture);
					
					var UVWremappingTransformUniform = shader_get_uniform(BackdropLighting,"UVWNormalRemappingTransform");
					shader_set_uniform_f_array(UVWremappingTransformUniform, calculateUVWRemappingDataWithTextures(diffuseMapTexture, normalMapTexture));
				}
				
				if(number_of_texture_channels >= textures_diffuse_and_normals_and_specular){
					if(!surface_exists(existingRegion.surface_specular)){
						existingRegion.surface_specular = IGNORE_debris_surface_create_specular_surface_for_region(existingRegion);
					}
				    var specularMapUniform = shader_get_sampler_index(BackdropLighting,"specularMap");
					var specularMapTexture = surface_get_texture(existingRegion.surface_specular);
					texture_set_stage(specularMapUniform, specularMapTexture);
					
					var UVWremappingTransformUniform = shader_get_uniform(BackdropLighting,"UVWSpecularRemappingTransform");
					shader_set_uniform_f_array(UVWremappingTransformUniform, calculateUVWRemappingDataWithTextures(diffuseMapTexture, specularMapTexture));
				}
				
			    time = shader_get_uniform(BackdropLighting,"uTime");
			    shader_set_uniform_f(time, current_time/1000);
			
				if(!surface_exists(existingRegion.surface)){
					existingRegion.surface = IGNORE_debris_surface_create_diffuse_surface_for_region(existingRegion);
				}
				draw_surface(existingRegion.surface, existingRegion.xStart, existingRegion.yStart);
			
			shader_reset();
		
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
