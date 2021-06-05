debris_compositeDrawing(rotation,
	function(){
		draw_sprite_ext(spr_blood, 0, 0, 0,size,size, 0, c_white, 1.0);
	},
	function(){
		/*
		gpu_set_blendmode(bm_dest_color);
		draw_sprite_ext(spr_blood, 1, 0, 0,size,size, rotation, c_white, 0.7);
		gpu_set_blendmode(bm_normal);*/
	}, 1,
	function(){
		draw_sprite_ext(spr_blood, 2, 0, 0,size,size, 0, c_white, 1.0);
	}
);