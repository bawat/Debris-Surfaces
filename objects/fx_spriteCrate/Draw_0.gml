if(isBeingDrawnToDebrisSurface_Normals()){
	draw_sprite_ext(spr_block, 1, x, y,1,1, rotation, c_white, 1.0);
}else if(isBeingDrawnToDebrisSurface_Specular()){
	draw_sprite_ext(spr_block, 2, x, y,1,1, rotation, c_white, 1.0);
}else{
	draw_sprite_ext(spr_block, 0, x, y,1,1, rotation, c_white, 1.0);
}
