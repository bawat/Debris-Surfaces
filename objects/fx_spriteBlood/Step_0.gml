size += size_acceleration;
if(size_acceleration > 0){
	size_acceleration -= 0.001;
}else{
	size_acceleration = 0;
	alarm[0] = 1;
}