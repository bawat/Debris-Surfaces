if(isBeingDrawnToDebrisSurface_Normals()){
	/*gpu_set_blendmode(bm_dest_color);
	draw_sprite_ext(spr_blood, 1, x, y,size,size, rotation, c_white, 0.7);
	gpu_set_blendmode(bm_normal);*/
}else if(isBeingDrawnToDebrisSurface_Specular()){
	draw_sprite_ext(spr_blood, 2, x, y,size,size, rotation, c_white, 1.0);
}else{
	draw_sprite_ext(spr_blood, 0, x, y,size,size, rotation, c_white, 0.7);
}
