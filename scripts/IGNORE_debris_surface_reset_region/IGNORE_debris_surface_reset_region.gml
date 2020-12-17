/// @author Bawat (bawat@hotmail.co.uk)
/// @description Resets the GPU after writing to the specific region
function IGNORE_debris_surface_reset_region() {
	gpu_set_colorwriteenable(true, true, true, true);
	surface_reset_target();
}
