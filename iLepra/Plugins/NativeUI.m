//
//  NativeUI.m
//  iLepra
//
//  Created by Tim Ermilov on 7/4/12.
//  Copyright (c) 2012 Uni Leipzig. All rights reserved.
//

#import "NativeUI.h"


@implementation NativeUI

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
    
    // set title
    controller.MainTitle.title = [options objectForKey:@"title"];
    
    // set left side item
    if( showBack ){
        [controller.MainTitle setLeftBarButtonItem:[[UIBarButtonItem alloc]
                                                    initWithTitle:@"Назад" style:UIBarButtonItemStyleBordered
                                                    target:nil action:nil]];
    }else{
        [controller.MainTitle setLeftBarButtonItem:controller.MenuButton];
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
                  action:@selector(refresh:)], nil];
    }else if( showRefresh ){
        items = [NSArray arrayWithObject:[[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh 
                                                   target:self 
                                                   action:@selector(refresh:)]];
    }else if( showOrganize ){
        items = [NSArray arrayWithObject:[[UIBarButtonItem alloc]
                                                   initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize 
                                                   target:self 
                                                   action:@selector(refresh:)]];
    }else{
        items = [NSArray array];
    }
    
    controller.MainTitle.rightBarButtonItems = items;
}

- (void) refresh: (id) sender
{
    
}

@end
