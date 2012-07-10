(function(){

	/* Get local ref to global PhoneGap/Cordova/cordova object for exec function.
		- This increases the compatibility of the plugin. */
	var cordovaRef = window.PhoneGap || window.Cordova || window.cordova; // old to new fallbacks

	var splashHidden = false;

 	// 
	function NativeUI() { }
 
	// set main app title and buttons
	NativeUI.prototype.setTitle = function(options) {
		// convert bool to int
		for(var i in options){
			if( options[i] === true ){
				options[i] = 1;
			}else if( options[i] === false ){
				options[i] = 0;
			}
		}
		cordovaRef.exec("NativeUI.setTitle", options);
	};

	// set main app title
	NativeUI.prototype.hideSplash = function() {
		if( !splashHidden ){
			splashHidden = true;
			cordovaRef.exec("NativeUI.hideSplash");
		}
	};

	// register for callback
	NativeUI.prototype.registerCallback = function(options) {
		cordovaRef.exec("NativeUI.registerCallback", options);
	};

	// enable/disable interactions
	NativeUI.prototype.disableInteractions = function() {
		cordovaRef.exec("NativeUI.disableInteractions");
	};
	NativeUI.prototype.enableInteractions = function() {
		cordovaRef.exec("NativeUI.enableInteractions");
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