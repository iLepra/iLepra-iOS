(function(){
    var animateTime = 220;

    var clearOld = function(){
        var cleanFunc = window["clean" + $.mobile.activePage.attr('id')];
        if( cleanFunc != null )
            cleanFunc();
    }

    window.oniLepraMenuSelect = function(data){
        switch(data){
            case "Посты":
                setTimeout(function(){
                    clearOld();
                    $.mobile.changePage("#postsPage");
                }, animateTime)
                break;
            case "Мои вещи":
                setTimeout(function(){
                    clearOld();
                    $.mobile.changePage("#mystuffPage");
                }, animateTime)
                break;    
            case "Инбокс":
                setTimeout(function(){
                    clearOld();
                    $.mobile.changePage("#inboxPage");
                }, animateTime)
                break;
            case "Избранное":
                setTimeout(function(){
                    clearOld();
                    $.mobile.changePage("#favsPage");
                }, animateTime)
                break;    
            case "Мои подлепры":
                setTimeout(function(){
                    clearOld();
                    iLepra.sub.list = iLepra.userSubLepras;
                    iLepra.sub.fetch = false;
                    $.mobile.changePage("#subsPage", {allowSamePageTransition: true});
                }, animateTime)
                break;
            case "Блоги империи":
                setTimeout(function(){
                    clearOld();
                    iLepra.sub.fetch = true;
                    $.mobile.changePage("#subsPage", {allowSamePageTransition: true});
                }, animateTime)
                break;
            case "Белый дом":
                setTimeout(function(){
                    clearOld();
                    $.mobile.changePage("#govPage");
                }, animateTime)
                break;            
            case "Чятик":
                setTimeout(function(){
                    clearOld();
                    $.mobile.changePage("#chatPage");
                }, animateTime)
                break;
            case "Выход":
                setTimeout(function(){
                    clearOld();
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
            
            
            case "Профиль":
                profileName = iLepra.username;
                setTimeout(function(){
                    clearOld();
                    $.mobile.changePage("#profilePage");
                }, animateTime)
                break;
        }
    };
})();