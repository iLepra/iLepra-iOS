(function(){
    var postLimit = iLepra.config.postIncrement,
        inboxList = null,
        moreInboxBtn = null,
        cleaned = true,
        currentScroll = 0;

    var renderNewPosts = function(){
        // render posts
        var limit = postLimit > iLepra.inboxPosts.length ? iLepra.inboxPosts.length : postLimit;
        var p = "";
        for(var i = 0; i < limit; i++)
            p += _.template(postTemplate, iLepra.inboxPosts[i]);

        inboxList.empty();
        inboxList.append(p);
        try{
            inboxList.listview('refresh');
        }catch(e){}
    };

    // render page on creation
    $(document).on('pagecreate', "#inboxPage", function(){
        inboxList = $("#inboxList");
        moreInboxBtn = $("#moreInboxButton");

        // more posts click
        moreInboxBtn.bind("tap", function(event){
            // stops event to prevent random post opening
            event.preventDefault();
            event.stopPropagation();

            postLimit += postLimit;
            if( postLimit >= iLepra.inboxPosts.length ){
                moreInboxBtn.hide();
            }

            // clean old data
            renderNewPosts();
        });
    });
    $(document).on('pagebeforehide', "#inboxPage", function(){
        if( !cleaned ) currentScroll = $(document).scrollTop();
    });
    $(document).on('pagebeforeshow', "#inboxPage", function(){
        $.mobile.silentScroll(currentScroll);
        
        window.plugins.nativeUI.setTitle({title: "Инбокс", organize: false, refresh: false, menu: true});

        lastPages = ["#inboxPage"];

        updateNewsCounts();
    });
    $(document).on('pageshow', "#inboxPage", function(){
        if( !cleaned ) return;

        $.mobile.showPageLoadingMsg();

        $(document).bind(iLepra.events.ready, function(event){
            $(document).unbind(event);

            // hide loading msg
            $.mobile.hidePageLoadingMsg();

            cleaned = false;
            renderNewPosts();

            // hide button if needed
            if( postLimit < iLepra.inboxPosts.length ){
                moreInboxBtn.show();
            }
        });
        iLepra.getInbox();
    });

    window.cleaninboxPage = function(){
        cleaned = true;
        currentScroll = 0;

        if( $.mobile.activePage.attr('id') == "inboxPage" ) return;
        inboxList.empty();
    };
})();