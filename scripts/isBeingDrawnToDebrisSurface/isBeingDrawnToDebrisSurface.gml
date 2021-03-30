/// @author Bawat (bawat@hotmail.co.uk)
/// @description To be used inside any object's Draw event to section out any code
///              that shouldn't be drawn to the debris surface for whatever reason the user sees fit
function isBeingDrawnToDebrisSurface() {
	if(!variable_global_exists("debris_isBeingDrawnToDebrisSurface")){
		global.debris_isBeingDrawnToDebrisSurface = false;
	}
	return global.debris_isBeingDrawnToDebrisSurface;
}
function isBeingDrawnToDebrisSurface_Diffuse() {
	if(!isBeingDrawnToDebrisSurface()) return false;
	if(!variable_global_exists("debris_requestedTextureFromCompositeGraphicProvider")){
		global.debris_requestedTextureFromCompositeGraphicProvider = IGNORE_debris_provide_diffuse;
	}
	return global.debris_requestedTextureFromCompositeGraphicProvider == IGNORE_debris_provide_diffuse;
}
function isBeingDrawnToDebrisSurface_Normals() {
	if(!isBeingDrawnToDebrisSurface()) return false;
	if(!variable_global_exists("debris_requestedTextureFromCompositeGraphicProvider")){
		global.debris_requestedTextureFromCompositeGraphicProvider = IGNORE_debris_provide_diffuse;
	}
	return global.debris_requestedTextureFromCompositeGraphicProvider == IGNORE_debris_provide_normals;
}
function isBeingDrawnToDebrisSurface_Specular() {
	if(!isBeingDrawnToDebrisSurface()) return false;
	if(!variable_global_exists("debris_requestedTextureFromCompositeGraphicProvider")){
		global.debris_requestedTextureFromCompositeGraphicProvider = IGNORE_debris_provide_diffuse;
	}
	return global.debris_requestedTextureFromCompositeGraphicProvider == IGNORE_debris_provide_specular;
}

#macro IGNORE_debris_provide_diffuse "diffuse"
#macro IGNORE_debris_provide_normals "normals"
#macro IGNORE_debris_provide_specular "specular"