/// @author Bawat (bawat@hotmail.co.uk)
/// @description Creates an onscreen region, prepares it's surface and sets it up to be initialised by the backdrop drawer
/// @param val1 TopLeft x
/// @param val2 TopLeft y
/// @param val3 BottomRight x
/// @param val4 BottomRight y
/// @return new region
function IGNORE_debris_surface_new_region(argument0, argument1, argument2, argument3) {
	topLeftX = argument0;
	topLeftY = argument1;
	bottomRightX = argument2;
	bottomRightY = argument3;

	if(!variable_global_exists("all_debris_surface_regions")){
		global.all_debris_surface_regions = array_create(0);
	}
	var numberOfRegions = array_length(global.all_debris_surface_regions);
	var region = {
	 xStart : topLeftX,
	 yStart : topLeftY,
	 xEnd : bottomRightX,
	 yEnd : bottomRightY,
	 hasBeenInitialised : false
	}

	//Quick check just in case I try to create a region that already exists
	forEach(global.all_debris_surface_regions, function(element){
		if(element.xStart == topLeftX){
		if(element.yStart == topLeftY){
		if(element.xEnd == bottomRightX){
		if(element.yEnd == bottomRightY){
			show_error("Tried to add a region that already exists.", true);
		}}}}
	});

	region.surface = IGNORE_debris_surface_create_surface_for_region(region);

	//Add the new region into the region list
	global.all_debris_surface_regions[numberOfRegions] = region;

	//Returns the new region
	return region;


}
