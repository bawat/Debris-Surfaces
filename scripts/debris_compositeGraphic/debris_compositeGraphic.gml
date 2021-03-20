/// @author Bawat (bawat@hotmail.co.uk)
/// @description Lets the user specify the diffuse, normals and specular graphics. debris_add_this relies upon this method to provide the correct graphic for the correct circumstance.
/// @param diffuseSpriteOrSurface The diffuse sprite to provide when asked
/// @param OPTIONAL normalsSpriteOrSurface The normals sprite to provide when asked
/// @param OPTIONAL specularSpriteOrSurface The specular sprite to provide when asked
function debris_compositeGraphic(diffuseSpriteOrSurface) {
    var normals = pointer_null; if(argument_count >= 2) { normals = argument[1]; }
    var specular = pointer_null; if(argument_count >= 3) { specular = argument[2]; }
    
    #macro IGNORE_debris_provide_diffuse "diffuse"
    #macro IGNORE_debris_provide_normals "normals"
    #macro IGNORE_debris_provide_specular "specular"
    
    if(!variable_global_exists("debris_requested_from_composite_sprite")){
        global.debris_requestedTextureFromCompositeGraphicProvider = IGNORE_debris_provide_diffuse;
    }
    
    switch(global.debris_requestedTextureFromCompositeGraphicProvider){
        case IGNORE_debris_provide_specular: return specular;
        case IGNORE_debris_provide_normals: return normals;
        case IGNORE_debris_provide_diffuse: return diffuseSpriteOrSurface;
    }
}