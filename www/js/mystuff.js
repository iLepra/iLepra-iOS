(function(){
    var postLimit = iLepra.config.postIncrement,
        mystuffList = null,
        mystuffMoreBtn = null,
        cleaned = true,
        currentScroll = 0;

    var renderNewPosts = function(){
        // render posts
        var limit = postLimit > iLepra.myStuffPosts.length ? iLepra.myStuffPosts.length : postLimit;
        var p = "";
        for(var i = 0; i < limit; i++)
            p += _.template(postTemplate, iLepra.myStuffPosts[i]);

        mystuffList.empty();
        mystuffList.append(p);
        try{
            mystuffList.listview('refresh');
        }catch(e){}
    };

    // render page on creation
    $(document).on('pagecreate', "#mystuffPage", function(){
        mystuffList = $("#mystuffList");
        mystuffMoreBtn = $("#moreMystuffButton");

        // more posts click
        mystuffMoreBtn.bind("tap", function(e){
            // stops event to prevent random post opening
            e.preventDefault();
            e.stopPropagation();

            postLimit += postLimit;
            if( postLimit >= iLepra.myStuffPosts.length ){
                mystuffMoreBtn.hide();
            }

            // clean old data
            renderNewPosts();
        });
    });
    $(document).on('pagebeforehide', "#mystuffPage", function(event){
        if( !cleaned ) currentScroll = $(document).scrollTop();
    });
    $(document).on('pagebeforeshow', "#mystuffPage", function(){
        window.plugins.nativeUI.setTitle({title: "Мои вещи", organize: false, refresh: false, menu: true});

        lastPages = ["#mystuffPage"];

        updateNewsCounts();
    });
    $(document).on('pageshow', "#mystuffPage", function(){
        $.mobile.silentScroll(currentScroll);

        if( !cleaned ) return;

        $.mobile.showPageLoadingMsg();

        $(document).bind(iLepra.events.ready, function(event){
            $(document).unbind(event);

            // hide loading msg
            $.mobile.hidePageLoadingMsg();

            cleaned = false;
            renderNewPosts();

            // hide button if needed
            if( postLimit < iLepra.myStuffPosts.length ){
                mystuffMoreBtn.show();
            }
        });
        iLepra.getMyStuff();
    });

    window.cleanmystuffPage = function(){
        cleaned = true;
        currentScroll = 0;

        if( $.mobile.activePage.attr('id') == "mystuffPage" ) return;
        mystuffList.empty();
    };
})();