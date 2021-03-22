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
		IGNORE_drawDefaultBackdrop(region.xStart, region.yStart, global.debris_default_backdrop.diffuse);
	surface_reset_target();
	return surf;
}
/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates a surface with the dimensions of a passed in regionID
function IGNORE_debris_surface_create_normal_surface_for_region(region) {
	var surf = IGNORE_debris_surface_create_surface_for_region(region);
	surface_set_target(surf);
		IGNORE_drawDefaultBackdrop(region.xStart, region.yStart, global.debris_default_backdrop.normal);
	surface_reset_target();
	return surf;
}
/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates a surface with the dimensions of a passed in regionID
function IGNORE_debris_surface_create_specular_surface_for_region(region) {
	var surf = IGNORE_debris_surface_create_surface_for_region(region);
	surface_set_target(surf);
		IGNORE_drawDefaultBackdrop(region.xStart, region.yStart, global.debris_default_backdrop.specular);
	surface_reset_target();
	return surf;
}
function IGNORE_drawDefaultBackdrop(absoluteTopLeftX, absoluteTopLeftY, spriteIndex){
	var transformToSurfaceOriginX = absoluteTopLeftX;
	var transformToSurfaceOriginY = absoluteTopLeftY;
	
	var spriteWidth = sprite_get_width(spriteIndex);
	var spriteHeight = sprite_get_height(spriteIndex);
	
	var numberOfTimesToTileX = ceil(region_width*2/spriteWidth);
	var numberOfTimesToTileY = ceil(region_height*2/spriteHeight);
	
	var lowestTileOriginX = floor(absoluteTopLeftX/spriteWidth) * spriteWidth;
	var lowestTileOriginY = floor(absoluteTopLeftY/spriteHeight) * spriteHeight;
	
	for(var xi = 0; xi < numberOfTimesToTileX; xi++){
		for(var yi = 0; yi < numberOfTimesToTileY; yi++){
			var xp = lowestTileOriginX + xi * spriteWidth;
			var yp = lowestTileOriginY + yi * spriteHeight;
			
			draw_sprite(spriteIndex, 0, xp - transformToSurfaceOriginX, yp - transformToSurfaceOriginY);
		}
	}
}