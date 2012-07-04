(function(){
    // render page on creation
    $(document).on('pageshow', "#govPage", function(){
        window.plugins.nativeUI.setTitle("Белый дом");
    	
        $.mobile.showPageLoadingMsg()

        $(document).bind(iLepra.events.ready, function(event){
            $(document).unbind(event);

            // hide loading msg
            $.mobile.hidePageLoadingMsg()

            // render posts
            $("#president").html(
                "<a href='#' class='username'>"+iLepra.gov.president + "</a> - " + iLepra.gov.time
            );
        });
        iLepra.gov.getCurrent();
    });
})();