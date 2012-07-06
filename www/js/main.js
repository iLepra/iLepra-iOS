// prepare
//window.addEventListener('load', function(){
document.addEventListener("deviceready", function(){
    ////////
    var getLatestPosts = function(){
        // on posts data
        $(document).bind(iLepra.events.ready, function(event){
            // unbind
            $(document).unbind(event);

            $.mobile.changePage("#postsPage");
        });

        // get posts
        iLepra.getLastPosts(true);
    }

    // bind event listener for initialization
    $(document).bind(iLepra.events.init, function(event){
        $(document).unbind(event);

        if(!iLepra.isAuthenticated){
            // navigate to login page
            $.mobile.changePage("#loginPage");
        }else{
            // get posts
            getLatestPosts();
        }
    });
    
    $(document).on("pageshow", "#loginPage", function(){
        window.plugins.nativeUI.setTitle({title: "iLepra", menu: false, back:false, refresh: false, organize: false});
    	
        // load captcha
        $("#captchaImage").attr('src', iLepra.captchaURL);

        // bind yarr click
        $("#loginButton").bind("tap", function(){
            $.mobile.showPageLoadingMsg();

            // create auth data structure
            var data = {
                user: $("#username").val(),
                pass: $("#pass").val(),
                captcha: $("#captcha").val().toLowerCase(),
                save: $("#rememberme").is(":checked") ? 1 : 0
            };

            // on login error
            $(document).bind(iLepra.events.error, function(event){
                // unbind
                $(document).unbind(event);

                // remove loader
                $.mobile.hidePageLoadingMsg();

                // display error message
                iLepra.ui.showError(iLepra.errorMessage);

                // refresh captcha
                $("#captchaImage").attr('src', iLepra.captchaURL);
            });

            // prepare ready event
            $(document).bind(iLepra.events.ready, function(event){
                // unbind current event
                $(document).unbind(event);
                // unbind error event
                $(document).unbind(iLepra.events.error);

                // get posts
                getLatestPosts();
            });

            // try logging in
            iLepra.tryLogin(data);
        });
        
        window.plugins.nativeUI.hideSplash();
    });

    // Init iLepra class
    iLepra.init();
});