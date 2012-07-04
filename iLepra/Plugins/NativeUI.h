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
}

// Set main app title  
- (void)hideSplash:(NSMutableArray*)hide withDict:(NSMutableDictionary*)options;

// Set main app title  
- (void)setTitle:(NSMutableArray*)title withDict:(NSMutableDictionary*)options;

@end
