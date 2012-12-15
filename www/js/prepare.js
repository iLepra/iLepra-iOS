window.addEventListener('load', function(){
    // jquery mobile stuff
    $.support.cors = true;
    $.mobile.allowCrossDomainPages = true;
    $.mobile.phonegapNavigationEnabled = true;
    $.mobile.loadingMessageTextVisible = true;
    $.mobile.loadingMessage = "Загружаемся ...";
    $.mobile.fixedtoolbar.prototype.options.tapToggle = false;
    $.mobile.defaultPageTransition = 'none';
    $.mobile.defaultDialogTransition = 'none';
    
    // override link handling
    $(document).on(iLepra.config.defaultTapEvent, "a", function(e){
        var link = $(this).attr('href');
        if(link.indexOf('http://') != -1){
            e.preventDefault();
            e.stopImmediatePropagation();
            window.plugins.childBrowser.showWebPage(link);
        }
    });

    // override show/hide loading msg to block menu
    var interactionDisabled = false;
    var oldShow = $.mobile.showPageLoadingMsg;
    var oldHide = $.mobile.hidePageLoadingMsg;
    $.mobile.showPageLoadingMsg = function(){
        window.plugins.nativeUI.disableInteractions();
        interactionDisabled = true;
        oldShow();
    };
    $.mobile.hidePageLoadingMsg = function(){
        if( interactionDisabled ){
            window.plugins.nativeUI.enableInteractions();
            interactionDisabled = false;
        }
        oldHide();
    };
});