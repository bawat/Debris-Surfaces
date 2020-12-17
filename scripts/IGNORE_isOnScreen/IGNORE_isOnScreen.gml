/// @author Bawat (bawat@hotmail.co.uk)
/// @description Checks to see if the current object (Or x,y coordinate) is currently in view.
/// @param val1 OPTIONAL The x coordinate to test
/// @param val2 OPTIONAL The y coordinate to test
/// @return boolean if the x,y coordinate is on screen
function IGNORE_isOnScreen() {

	var onScreen = true;

	var xp = x;
	var yp = y;

	if(argument_count == 2){
		xp = argument[0];
		yp = argument[1];
	}

	var camx = camera_get_view_x(view_camera[0]);
	var camy = camera_get_view_y(view_camera[0]);
	var camw = camera_get_view_width(view_camera[0]);
	var camh = camera_get_view_height(view_camera[0]);

	onScreen = onScreen && (xp >= camx && xp <= camx + camw);
	onScreen = onScreen && (yp >= camy && yp <= camy + camh);

	return onScreen;


}
