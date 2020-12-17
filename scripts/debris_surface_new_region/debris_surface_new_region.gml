/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates an onscreen region, prepares it's surface and sets it up to be initialised by the backdrop drawer
/// @param val1 TopLeft x
/// @param val2 TopLeft y
/// @param val3 BottomRight x
/// @param val4 BottomRight y
/// @return new regionID
function debris_surface_new_region(argument0, argument1, argument2, argument3) {

	if(!variable_global_exists("debris_surface_regions")){
		global.debris_surface_regions = array_create(0);
	}
	/*
	var region = {
	 xStart : argument0,
	 yStart : argument1,
	 xEnd : argument2,
	 yEnd : argument3
	}
	*/
	var numberOfRegions = array_length_1d(global.debris_surface_regions);
	var region = 0;
	region[region_xStart] = argument0;
	region[region_yStart] = argument1;
	region[region_xEnd] = argument2;
	region[region_yEnd] = argument3;

	//Quick check just in case I try to create a region that already exists
	for(var i = 0; i < numberOfRegions; i++){
		var existingRegion = global.debris_surface_regions[i];
		if(existingRegion[region_xStart] == region[region_xStart]){
		if(existingRegion[region_yStart] == region[region_yStart]){
		if(existingRegion[region_xEnd] == region[region_xEnd]){
		if(existingRegion[region_yEnd] == region[region_yEnd]){
			show_error("Tried to add a region that already exists.", true);
		}}}}
	}

	region[region_surface] = debris_surface_create_surface_for_region(region);
	region[region_initialised] = false;

	//Add the new region into the region list
	global.debris_surface_regions[numberOfRegions] = region;

	//Returns the new regionID
	return numberOfRegions;


}
