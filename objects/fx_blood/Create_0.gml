var size = 1 + random(1);
var timeoutTime = 500;

bloodSpreadSystem = part_system_create();
part_system_depth(bloodSpreadSystem, 30);
part_system_automatic_draw(bloodSpreadSystem, false);

bloodParticle = part_type_create();
part_type_shape(bloodParticle, pt_shape_cloud);
part_type_size(bloodParticle, size, size, 0.003, 0);
part_type_color1(bloodParticle, c_red);
part_type_alpha2(bloodParticle, 1, 0.0);
part_type_orientation(bloodParticle,0,359,0,0,true);
part_type_life(bloodParticle, timeoutTime, timeoutTime);

alarm[0] = timeoutTime/2;

bloodEmitter = part_emitter_create(bloodSpreadSystem);
part_emitter_region(bloodSpreadSystem, bloodEmitter, 0, 0, 0, 0, ps_shape_ellipse, ps_distr_linear);

//Run the effect
part_system_position(bloodSpreadSystem, x, y);

part_emitter_burst(bloodSpreadSystem, bloodEmitter, bloodParticle, 1);