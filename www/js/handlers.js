(function(){
    var handleImageError = function(element){
        $(element).parents('li').removeClass('ui-li-has-thumb');
        $(element).parent().append("&nbsp;");
        $(element).remove();
    }
    window.handleImageError = handleImageError;

    // phonegap native ui events handling
    window.oniLepraPostBack = function(){
    	$.mobile.changePage(lastPages.pop(), {reverse: true}); 
	};
	window.oniLepraDoRefresh = function(){
        window.oniLepraDoRefreshPost();
		window.oniLepraDoRefreshPosts();
    };

	// assign events
	document.addEventListener("deviceready", function(){
	    window.plugins.nativeUI.registerCallback({action: "back", callback: "oniLepraPostBack"});
	    window.plugins.nativeUI.registerCallback({action: "menu", callback: "oniLepraMenuSelect"});
	    window.plugins.nativeUI.registerCallback({action: "refresh", callback: "oniLepraDoRefresh"});

	    // window.oniLepraMainChange - change of main posts
	});
})();