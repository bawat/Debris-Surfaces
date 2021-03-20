/// @author Bawat (bawat@hotmail.co.uk)
/// @description Draw to this specific region
/// @param val1 regionID
/// @param val2 diffuseDrawLamda
/// @param val3 (Optional) normalsDrawLamda
/// @param val4 (Optional) specilarDrawLamda
function IGNORE_debris_surface_drawTo_region(region, diffuseDrawLamda) {
	gpu_set_colorwriteenable(true, true, true, false);//Turn alpha drawing off - otherwise the transparency won't be mixed correctly
	
	
    if (!surface_exists(region.surface)) {
		region.surface = IGNORE_debris_surface_create_diffuse_surface_for_region(region);
	}
	if(!is_method(diffuseDrawLamda)) { show_error("Expected diffuseLamda, but got something different.", true); }
	surface_set_target(region.surface);
		 diffuseDrawLamda();
	surface_reset_target();
	
	if(argument_count > 2){
		if(texture_storage_map_count < texture_storage_diffuse_and_normal_map) { show_error("Tried to draw to normal map, when normal maps aren't enabled in the debris_CONFIG.", true); }
		if (!surface_exists(region.surface_normal)) {
			region.surface_normal = IGNORE_debris_surface_create_normal_surface_for_region(region);
		}
		var normalsLamda = argument[2];
		if(!is_method(normalsLamda)) { show_error("Expected normalsLamda, but got something different.", true); }
		surface_set_target(region.surface_normal);
			normalsLamda();
		surface_reset_target();
	}
	
	if(argument_count > 3){
		if(texture_storage_map_count < texture_storage_diffuse_and_normals_and_specular) { show_error("Tried to draw to specular map, when normal maps aren't enabled in the debris_CONFIG.", true); }
		if (!surface_exists(region.surface_specular)) {
			region.surface_specular = IGNORE_debris_surface_create_specular_surface_for_region(region);
		}
		var specularLamda = argument[2];
		if(!is_method(specularLamda)) { show_error("Expected specularLamda, but got something different.", true); }
		surface_set_target(region.surface_specular);
			specularLamda();
		surface_reset_target();
	}
	
	gpu_set_colorwriteenable(true, true, true, true);
}
