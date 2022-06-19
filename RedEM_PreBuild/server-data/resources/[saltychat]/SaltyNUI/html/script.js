$(function(){
	window.addEventListener('message', function(event) {
		if (event.data.action == "toggleWindow"){
		if(event.data.value == "true"){
			
			displayPluginScreen(event.data.value);
			}else{
			
			displayPluginScreen(false);
			}

		}
	});

});


function displayPluginScreen(toggle) {
	document.getElementById('pluginScreen').style.display = (toggle) ? 'block' : 'none';
}


