/// @author Bawat (bawat@hotmail.co.uk)
/// @description To be used inside any object's Draw event to section out any code
///              that shouldn't be drawn to the debris surface for whatever reason the user sees fit
function isBeingDrawnToDebrisSurface() {
	if(!variable_global_exists("debris_isBeingDrawnToDebrisSurface")){
		global.debris_isBeingDrawnToDebrisSurface = false;
	}
	return global.debris_isBeingDrawnToDebrisSurface;
}
