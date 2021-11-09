// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function IGNORE_xToXIndex(val) {
	var xIndex = floor(val/region_width)*2;
	if(xIndex < 0) {
		xIndex = abs(xIndex)-1;
	}
	return xIndex;
}
function IGNORE_yToYIndex(val) {
	var yIndex = floor(val/region_height)*2;
	if(yIndex < 0) {
		yIndex = abs(yIndex)-1;
	}
	return yIndex;
}

function IGNORE_regionFastFinder_Store(region){
	if(!variable_global_exists("all_debris_surface_regions_fastFinder")){
		global.all_debris_surface_regions_fastFinder = array_create(0);
	}
	
	var xIndex = IGNORE_xToXIndex(region.xStart),
		yIndex = IGNORE_yToYIndex(region.yStart);
	
	global.all_debris_surface_regions_fastFinder[xIndex, yIndex] = region;
}
function IGNORE_regionFastFinder_Retrieve(xPos, yPos){
	if(!variable_global_exists("all_debris_surface_regions_fastFinder")){
		global.all_debris_surface_regions_fastFinder = array_create(0);
	}
	
	var xIndex = IGNORE_xToXIndex(xPos),
		yIndex = IGNORE_yToYIndex(yPos);
	
	return global.all_debris_surface_regions_fastFinder[xIndex, yIndex];
}
function IGNORE_regionFastFinder_Exists(xStart, yStart){
	if(!variable_global_exists("all_debris_surface_regions_fastFinder")){
		global.all_debris_surface_regions_fastFinder = array_create(0);
	}
	
	var xIndex = IGNORE_xToXIndex(xStart),
		yIndex = IGNORE_yToYIndex(yStart);
	
	if(xIndex >= array_length(global.all_debris_surface_regions_fastFinder)){
		return false;
	}
	
	var subArray = global.all_debris_surface_regions_fastFinder[xIndex];
	if(!is_array(subArray) || yIndex >= array_length(subArray)){
		return false;
	}
	
	if(global.all_debris_surface_regions_fastFinder[xIndex, yIndex] == 0) {
		return false;
	}
	
	return true;
}