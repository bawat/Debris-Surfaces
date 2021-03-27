if(isBeingDrawnToDebrisSurface_Normals()) {return;}
if(isBeingDrawnToDebrisSurface_Specular()) {;
	gpu_set_blendmode_ext(bm_src_alpha, bm_one)
	gpu_set_fog(true,c_white,0,0);
	part_system_drawit(bloodSpreadSystem);
	gpu_set_fog(false,c_black,0,0);
	gpu_set_blendmode(bm_normal);
	return;
}
part_system_drawit(bloodSpreadSystem);