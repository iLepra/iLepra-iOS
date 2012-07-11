(function(){
    var animateTime = 220;

    var clearOld = function(){
        return window["clean" + $.mobile.activePage.attr('id')];
    }

    window.oniLepraMenuSelect = function(data){
        switch(data){
            case "Посты":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    $.mobile.changePage("#postsPage");
                    if( cleanFunc != null ) cleanFunc();
                }, animateTime)
                break;
            case "Мои вещи":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    $.mobile.changePage("#mystuffPage");
                    if( cleanFunc != null ) cleanFunc();
                }, animateTime)
                break;    
            case "Инбокс":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    $.mobile.changePage("#inboxPage");
                    if( cleanFunc != null ) cleanFunc();
                }, animateTime)
                break;
            case "Избранное":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    $.mobile.changePage("#favsPage");
                    if( cleanFunc != null ) cleanFunc();
                }, animateTime)
                break;    
            case "Мои подлепры":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    iLepra.sub.list = iLepra.userSubLepras;
                    iLepra.sub.fetch = false;
                    $.mobile.changePage("#subsPage", {allowSamePageTransition: true});
                    if( cleanFunc != null ) cleanFunc();
                }, animateTime)
                break;
            case "Блоги империи":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    iLepra.sub.fetch = true;
                    $.mobile.changePage("#subsPage", {allowSamePageTransition: true});
                    if( cleanFunc != null ) cleanFunc();
                }, animateTime)
                break;
            case "Белый дом":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    $.mobile.changePage("#govPage");
                    if( cleanFunc != null ) cleanFunc();
                }, animateTime)
                break;            
            case "Чятик":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    $.mobile.changePage("#chatPage");
                    if( cleanFunc != null ) cleanFunc();
                }, animateTime)
                break;
            case "Выход":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    $.mobile.showPageLoadingMsg();
                    $(document).bind(iLepra.events.ready, function(event){
                        $(document).unbind(event);
                        // bind event listener for initialization
                        $(document).bind(iLepra.events.init, function(event){
                            $(document).unbind(event);
                            // navigate to login page
                            $.mobile.changePage("#loginPage");
                            if( cleanFunc != null ) cleanFunc();
                        });
                        iLepra.init();
                    });
                    iLepra.doLogout();
                }, animateTime)
                break;    
            
            
            case "Профиль":
                profileName = iLepra.username;
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    $.mobile.changePage("#profilePage");
                    if( cleanFunc != null ) cleanFunc();
                }, animateTime)
                break;
        }
    };
})();