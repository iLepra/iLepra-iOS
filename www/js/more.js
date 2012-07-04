(function(){
    var animateTime = 220;

    //Ti.App
    $(document).addEventListener('iLepraMenuSelect', function onMenuSelect(data){
        //Ti.App.fireEvent('iLepraToggleMenu');
        
        switch(data.entry){
            case "posts":
                setTimeout(function(){
                    $.mobile.changePage("#postsPage");
                }, animateTime)
                break;
            case "mystuff":
                setTimeout(function(){
                    $.mobile.changePage("#mystuffPage");
                }, animateTime)
                break;    
            case "inbox":
                setTimeout(function(){
                    $.mobile.changePage("#inboxPage");
                }, animateTime)
                break;
            case "favs":
                setTimeout(function(){
                    $.mobile.changePage("#favsPage");
                }, animateTime)
                break;    
            case "mysubs":
                setTimeout(function(){
                    iLepra.sub.list = iLepra.userSubLepras;
                    iLepra.sub.fetch = false;
                    $.mobile.changePage("#subsPage", {allowSamePageTransition: true});
                }, animateTime)
                break;
            case "subs":
                setTimeout(function(){
                    iLepra.sub.fetch = true;
                    $.mobile.changePage("#subsPage", {allowSamePageTransition: true});
                }, animateTime)
                break;
            case "gov":
                setTimeout(function(){
                    $.mobile.changePage("#govPage");
                }, animateTime)
                break;            
            case "chat":
                setTimeout(function(){
                    $.mobile.changePage("#chatPage");
                }, animateTime)
                break;
            case "exit":
                setTimeout(function(){
                    $.mobile.showPageLoadingMsg();
                    $(document).bind(iLepra.events.ready, function(event){
                        $(document).unbind(event);
                        // bind event listener for initialization
                        $(document).bind(iLepra.events.init, function(event){
                            $(document).unbind(event);
                            // navigate to login page
                            $.mobile.changePage("#loginPage");
                        });
                        iLepra.init();
                    });
                    iLepra.doLogout();
                }, animateTime)
                break;    
            
            
            case "profile":
                profileName = iLepra.username;
                setTimeout(function(){
                    $.mobile.changePage("#profilePage");
                }, animateTime)
                break;
        }
    });
})();