//
//  NativeUI.m
//  iLepra
//
//  Created by Tim Ermilov on 7/4/12.
//  Copyright (c) 2012 Uni Leipzig. All rights reserved.
//

#import "NativeUI.h"


@implementation NativeUI

@synthesize callbackIds = _callbackIds;

- (NSMutableDictionary*)callbackIds {
	if(_callbackIds == nil) {
		_callbackIds = [[NSMutableDictionary alloc] init];
	}
	return _callbackIds;
}

- (CDVPlugin *)initWithWebView:(UIWebView *)theWebView 
{
    NSLog(@"plugin init");
    AppDelegate *myApp = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    myApp.nativeUI = self;
    
    NSLog(@"%@", myApp.nativeUI);
    
    return [super initWithWebView:theWebView];
}




- (void)registerCallback:(NSMutableArray *)arguments withDict:(NSMutableDictionary *)options
{
    NSLog(@"%@ for %@", [options objectForKey:@"callback"], [options objectForKey:@"action"]);
    
    // The first argument in the arguments parameter is the callbackID.
	[self.callbackIds setValue:[options objectForKey:@"callback"] forKey:[options objectForKey:@"action"]];
}

- (void)hideSplash:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    AppDelegate *myApp = (AppDelegate*)[UIApplication sharedApplication].delegate;
    MainViewController *controller = (MainViewController*)myApp.viewController;
    controller.SplashView.hidden = true;
    [controller.SplashView removeFromSuperview];
}

- (void)setTitle:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options
{
    AppDelegate *myApp = (AppDelegate*)[UIApplication sharedApplication].delegate;
    MainViewController *controller = (MainViewController*)myApp.viewController;// as MainViewController;
    
    bool showRefresh = [[options objectForKey:@"refresh"] intValue] == 1;
    bool showOrganize = [[options objectForKey:@"organize"] intValue]  == 1;
    bool showBack = [[options objectForKey:@"back"] intValue]  == 1;
    bool showMenu = [[options objectForKey:@"menu"] intValue]  == 1;
    
    // set title
    controller.MainTitle.title = [options objectForKey:@"title"];
    
    // set left side item
    if( showMenu ){
        [controller.MainTitle setLeftBarButtonItem:controller.MenuButton];
    }else if( showBack ){
        [controller.MainTitle setLeftBarButtonItem:[[UIBarButtonItem alloc]
                                                    initWithTitle:@"Назад" style:UIBarButtonItemStyleBordered
                                                    target:self action:@selector(back:)]];
    }else{
        [controller.MainTitle setLeftBarButtonItem:nil];
    }
    
    // set right side items
    NSArray *items;
    if( showRefresh && showOrganize ){
        items = [NSArray arrayWithObjects:[[UIBarButtonItem alloc] 
                                           initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                           target:self 
                                           action:@selector(refresh:)],
                 [[UIBarButtonItem alloc]
                  initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize 
                  target:self 
                  action:@selector(organize:)], nil];
    }else if( showRefresh ){
        items = [NSArray arrayWithObject:[[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                   target:self 
                                                   action:@selector(refresh:)]];
    }else if( showOrganize ){
        items = [NSArray arrayWithObject:[[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize 
                                                   target:self 
                                                   action:@selector(organize:)]];
    }else{
        items = [NSArray array];
    }
    
    controller.MainTitle.rightBarButtonItems = items;
}

- (void)menuSelected:(NSString*)entry
{
    NSString *jsStatement = [NSString stringWithFormat:@"window.%@(\"%@\");", [self.callbackIds objectForKey:@"menu"], entry];
    NSLog(@"Menu selected: %@", jsStatement);
	[self writeJavascript:jsStatement];
}

/*
 * toolbar buttons functions
 */
- (void)refresh: (id) sender
{
    NSString *jsStatement = [NSString stringWithFormat:@"window.%@();", [self.callbackIds objectForKey:@"refresh"]];
    NSLog(@"Refresh pressed: %@", jsStatement);
	[self writeJavascript:jsStatement];
}

- (void)organize: (id) sender
{
    //NSString *jsStatement = [NSString stringWithFormat:@"window.%@();", [self.callbackIds objectForKey:@"organize"]];
    //NSLog(@"Organize pressed: %@", jsStatement);
	//[self writeJavascript:jsStatement];
    AppDelegate *myApp = (AppDelegate*)[UIApplication sharedApplication].delegate;
    MainViewController *controller = (MainViewController*)myApp.viewController;// as MainViewController;
}

- (void)back: (id) sender
{
    NSString *jsStatement = [NSString stringWithFormat:@"window.%@();", [self.callbackIds objectForKey:@"back"]];
    NSLog(@"Back pressed: %@", jsStatement);
	[self writeJavascript:jsStatement];
}

@end
