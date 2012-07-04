//
//  NativeUI.m
//  iLepra
//
//  Created by Tim Ermilov on 7/4/12.
//  Copyright (c) 2012 Uni Leipzig. All rights reserved.
//

#import "NativeUI.h"


@implementation NativeUI

- (void)hideSplash:(NSMutableArray*)hide withDict:(NSMutableDictionary*)options
{
    AppDelegate *myApp = (AppDelegate*)[UIApplication sharedApplication].delegate;
    MainViewController *controller = (MainViewController*)myApp.viewController;
    controller.SplashView.hidden = true;
    [controller.SplashView removeFromSuperview];
}

- (void)setTitle:(NSMutableArray*)title withDict:(NSMutableDictionary*)options
{
    AppDelegate *myApp = (AppDelegate*)[UIApplication sharedApplication].delegate;
    MainViewController *controller = (MainViewController*)myApp.viewController;// as MainViewController;
    controller.MainTitle.title = [title objectAtIndex:0];
}

@end
