// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function IGNORE_draw_to_surface(drawLambda, surface, drawX, drawY, drawRotation){
	surface_set_target(surface);
	draw_to_surface_drawLambda = drawLambda;
	
	IGNORE_drawTransformAbsolute(drawX, drawY, drawRotation, function(){
		draw_to_surface_drawLambda();
	});
	
	surface_reset_target();
	return surface;
}