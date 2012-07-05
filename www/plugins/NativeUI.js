(function(){

	/* Get local ref to global PhoneGap/Cordova/cordova object for exec function.
		- This increases the compatibility of the plugin. */
	var cordovaRef = window.PhoneGap || window.Cordova || window.cordova; // old to new fallbacks

	var splashHidden = false;

 	// 
	function NativeUI() { }
 
	// set main app title
	NativeUI.prototype.setTitle = function(options) {
		for(var i in options){
			if( options[i] === true ){
				options[i] = 1;
			}else if( options[i] === false ){
				options[i] = 0;
			}
		}
		console.log('set options')
		console.log(options)
		cordovaRef.exec("NativeUI.setTitle", options);
	};

	// set main app title
	NativeUI.prototype.hideSplash = function() {
		if( !splashHidden ){
			splashHidden = true;
			cordovaRef.exec("NativeUI.hideSplash");
		}
	};

	// register plugin
	cordovaRef.addConstructor(function() {
		if(!window.plugins) {
			window.plugins = {};
		}
		if(!window.plugins.nativeUI) {
    		window.plugins.nativeUI = new NativeUI();
		}
	});

})();