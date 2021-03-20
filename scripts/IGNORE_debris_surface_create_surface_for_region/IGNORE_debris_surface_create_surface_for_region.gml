/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates a surface with the dimensions of a passed in regionID
/// @param val1 regionID
function IGNORE_debris_surface_create_surface_for_region(region) {
	return surface_create(region.xEnd-region.xStart, region.yEnd-region.yStart);
}
/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates a surface with the dimensions of a passed in regionID
function IGNORE_debris_surface_create_diffuse_surface_for_region(region) {
	var surf = IGNORE_debris_surface_create_surface_for_region(region);
	surface_set_target(surf);
		drawSprites(region.xStart, region.yStart, 0);
	surface_reset_target();
	return surf;
}
/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates a surface with the dimensions of a passed in regionID
function IGNORE_debris_surface_create_normal_surface_for_region(region) {
	var surf = IGNORE_debris_surface_create_surface_for_region(region);
	surface_set_target(surf);
		drawSprites(region.xStart, region.yStart, normal_map_sprite_index);
	surface_reset_target();
	return surf;
}
/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates a surface with the dimensions of a passed in regionID
function IGNORE_debris_surface_create_specular_surface_for_region(region) {
	var surf = IGNORE_debris_surface_create_surface_for_region(region);
	surface_set_target(surf);
		drawSprites(region.xStart, region.yStart, specular_map_sprite_index);
	surface_reset_target();
	return surf;
}
function drawSprites(absoluteTopLeftX, absoluteTopLeftY, imageIndex){
	var transformToSurfaceOriginX = absoluteTopLeftX;
	var transformToSurfaceOriginY = absoluteTopLeftY;
	
	var spriteWidth = sprite_get_width(global.debris_backdrop_sprite);
	var spriteHeight = sprite_get_height(global.debris_backdrop_sprite);
	
	var numberOfTimesToTileX = ceil(region_width*2/spriteWidth);
	var numberOfTimesToTileY = ceil(region_height*2/spriteHeight);
	
	var lowestTileOriginX = floor(absoluteTopLeftX/spriteWidth) * spriteWidth;
	var lowestTileOriginY = floor(absoluteTopLeftY/spriteHeight) * spriteHeight;
	
	for(var xi = 0; xi < numberOfTimesToTileX; xi++){
		for(var yi = 0; yi < numberOfTimesToTileY; yi++){
			var xp = lowestTileOriginX + xi * spriteWidth;
			var yp = lowestTileOriginY + yi * spriteHeight;
			
			draw_sprite(global.debris_backdrop_sprite, imageIndex, xp - transformToSurfaceOriginX, yp - transformToSurfaceOriginY);
		}
	}
}