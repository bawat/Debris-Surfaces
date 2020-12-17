/* EXAMPLE USAGE

array1 = 0;
array1[0] = 00;
array1[1] = 10;

forEach(myArray, function(element){
	show_debug_message("array: " + string(element));
}

bawat@hotmail.co.uk
*/
function forEach(collection, lamda){
	if(!is_method(lamda)) {show_error("Second argument must be a lamda", true)};
	var listOrArrayToIterate = collection;
	
	var elements = 0;
	if(is_array(listOrArrayToIterate)){
		elements = array_length(listOrArrayToIterate);
	}else{
		elements = ds_list_size(listOrArrayToIterate);
	}
	
	for(var i = 0; i < elements; i++){
		var element;
		if(is_array(listOrArrayToIterate)){
			element = listOrArrayToIterate[i];
		}else{
			element = listOrArrayToIterate[|i];
		}
		
		if(lamda(element)) {return;}
	}
}