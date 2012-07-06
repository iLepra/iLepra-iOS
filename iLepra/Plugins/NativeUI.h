//
//  NativeUI.h
//  iLepra
//
//  Created by Tim Ermilov on 7/4/12.
//  Copyright (c) 2012 Uni Leipzig. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Cordova/CDVPlugin.h>
#import "../Classes/AppDelegate.h"
#import "../Classes/MainViewController.h"

@interface NativeUI : CDVPlugin {
    NSMutableDictionary* callbackIds;
}

@property (nonatomic, retain) NSMutableDictionary* callbackIds;

- (void)hideSplash:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;
- (void)setTitle:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

- (void)registerCallback:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options;

- (void)menuSelected:(NSString*)entry;

@end
