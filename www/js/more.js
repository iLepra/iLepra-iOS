(function(){
    var animateTime = 220;

    var clearOld = function(){
        return window["clean" + $.mobile.activePage.attr('id')];
    };

    window.oniLepraMenuSelect = function(data){
        switch(data){
            case "Посты":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    if( cleanFunc !== null ) cleanFunc();
                    $.mobile.changePage("#postsPage");
                }, animateTime);
                break;

            case "Мои вещи":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    if( cleanFunc !== null ) cleanFunc();
                    $.mobile.changePage("#mystuffPage");
                }, animateTime);
                break;

            case "Инбокс":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    if( cleanFunc !== null ) cleanFunc();
                    $.mobile.changePage("#inboxPage");
                }, animateTime);
                break;

            case "Избранное":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    if( cleanFunc !== null ) cleanFunc();
                    $.mobile.changePage("#favsPage");
                }, animateTime);
                break;

            case "Мои подлепры":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    iLepra.sub.list = iLepra.userSubLepras;
                    iLepra.sub.fetch = false;
                    if( cleanFunc !== null ) cleanFunc();
                    $.mobile.changePage("#subsPage", {allowSamePageTransition: true});
                }, animateTime);
                break;

            case "Блоги империи":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    iLepra.sub.fetch = true;
                    if( cleanFunc !== null ) cleanFunc();
                    $.mobile.changePage("#subsPage", {allowSamePageTransition: true});
                }, animateTime);
                break;

            case "Белый дом":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    if( cleanFunc !== null ) cleanFunc();
                    $.mobile.changePage("#govPage");
                }, animateTime);
                break;

            case "Чятик":
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    if( cleanFunc !== null ) cleanFunc();
                    $.mobile.changePage("#chatPage");
                }, animateTime);
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
                            if( cleanFunc !== null ) cleanFunc();
                            $.mobile.changePage("#loginPage");
                        });
                        iLepra.init();
                    });
                    iLepra.doLogout();
                }, animateTime);
                break;
            
            case "Профиль":
                profileName = iLepra.username;
                setTimeout(function(){
                    var cleanFunc = clearOld();
                    if( cleanFunc !== null ) cleanFunc();
                    $.mobile.changePage("#profilePage");
                }, animateTime);
                break;
        }
    };
})();