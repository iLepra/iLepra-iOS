(function(){
    var subName = null,
        subUrl = null,
        postLimit = iLepra.config.postIncrement,

        // dom
        subsList = null,
        subpostsList = null,
        moreSubpostsBtn = null,

        // cleaning
        cleanedSubsList = true,
        cleanedSubsPosts = true,
        currentSubsScroll = 0,
        currentPostsScroll = 0;

    var rendreNew = function(){
        // render posts
        var p = "";
        for(var i = 0; i < iLepra.sub.list.length; i++)
            p += _.template(subsTemplate, iLepra.sub.list[i]);

        subsList.append(p);
        try{
            subsList.listview('refresh');
        }catch(e){}
    };

    // render page on creation
    $(document).on('pagecreate', "#subsPage", function(){
        subsList = $("#subsList");
    });
    $(document).on('pagebeforehide', "#subsPage", function(){
        if( !cleanedSubsList ) currentSubsScroll = $(document).scrollTop();
    });
    $(document).on('pagebeforeshow', "#subsPage", function(){
        $.mobile.silentScroll(currentSubsScroll);
        
        window.plugins.nativeUI.setTitle({title: "Подлепры", organize: false, refresh: false, menu: true});

        lastPages = ["#subsPage"];

        // clean sub
        if( subpostsList !== null ){
            currentPostsScroll = 0;
            cleanedSubsPosts = true;
            subpostsList.empty();
        }
    });
    $(document).on('pageshow', "#subsPage", function(){
        if( !cleanedSubsList ) return;

        if( iLepra.sub.fetch ){
            $.mobile.showPageLoadingMsg();

            $(document).bind(iLepra.events.ready, function(event){
                $(document).unbind(event);

                // hide loading msg
                $.mobile.hidePageLoadingMsg();

                cleanedSubsList = false;
                rendreNew();
            });
            iLepra.sub.getList();
        }else{
            cleanedSubsList = false;
            rendreNew();
        }
    });

    // sub click
    $(document).on("tap", "a.subListItem", function(e){
        e.preventDefault();
        e.stopImmediatePropagation();

        subName = $(this).children('h1').text();
        subUrl = $(this).data('link');

        $.mobile.changePage("#subpostsPage");
    });

    // render posts
    var renderNewPosts = function(){
        var limit = postLimit > iLepra.sub.posts.length ? iLepra.sub.posts.length : postLimit;
        var p = "";
        for(var i = 0; i < limit; i++)
            p += _.template(postTemplate, iLepra.sub.posts[i]);

        subpostsList.empty();
        subpostsList.append(p);
        try{
            subpostsList.listview('refresh');
        }catch(e){}
    };

    $(document).on('pagecreate', "#subpostsPage", function(){
        subpostsList = $("#subpostsList");
        moreSubpostsBtn = $("#moreSubpostsButton");

        // more btn
        moreSubpostsBtn.bind("tap", function(e){
            // stops event to prevent random post opening
            e.preventDefault();
            e.stopPropagation();

            if( postLimit < iLepra.sub.posts.length){
                postLimit += postLimit;

                // clean old data
                renderNewPosts();
            }else{ // load new data
                // show loader
                $.mobile.showPageLoadingMsg();

                // on posts data
                $(document).bind(iLepra.events.ready, function(event){
                    $(document).unbind(event);

                    // remove loader
                    $.mobile.hidePageLoadingMsg();

                    // clean old data
                    renderNewPosts();
                });

                // get posts
                iLepra.sub.getMorePosts(subUrl);
            }
        });
    });
    $(document).on('pagehide', "#subpostsPage", function(){
        if( !cleanedSubsPosts ) currentPostsScroll = $(document).scrollTop();
        
        moreSubpostsBtn.hide();
    });
    $(document).on('pagebeforeshow', "#subpostsPage", function(){
        $.mobile.silentScroll(currentPostsScroll);

        window.plugins.nativeUI.setTitle({title: subName, organize: false, refresh: false, back: true});
    });
    $(document).on('pageshow', "#subpostsPage", function(){
        if( !cleanedSubsPosts ) return;

        $.mobile.showPageLoadingMsg();

        // on posts data
        $(document).bind(iLepra.events.ready, function(event){
            $(document).unbind(event);

            // hide loading msg
            $.mobile.hidePageLoadingMsg();

            cleanedSubsPosts = false;
            moreSubpostsBtn.show();

            renderNewPosts();
        });

        // get posts
        iLepra.sub.getPosts(subUrl);
    });

    window.cleansubsPage = function(){
        currentSubsScroll = 0;
        cleanedSubsList = true;
        subsList.empty();
    };
})();