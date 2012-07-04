/*
 Licensed to the Apache Software Foundation (ASF) under one
 or more contributor license agreements.  See the NOTICE file
 distributed with this work for additional information
 regarding copyright ownership.  The ASF licenses this file
 to you under the Apache License, Version 2.0 (the
 "License"); you may not use this file except in compliance
 with the License.  You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing,
 software distributed under the License is distributed on an
 "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
 KIND, either express or implied.  See the License for the
 specific language governing permissions and limitations
 under the License.
 */

//
//  MainViewController.h
//  iLepra
//
//  Created by Tim Ermilov on 7/2/12.
//  Copyright Uni Leipzig 2012. All rights reserved.
//

#ifdef CORDOVA_FRAMEWORK
    #import <Cordova/CDVViewController.h>
#else
    #import "CDVViewController.h"
#endif

@interface MainViewController : CDVViewController <UITableViewDelegate, UITableViewDataSource> {
    NSMutableArray *menuItems;
}
@property (strong, nonatomic) IBOutlet UIView *MenuView;
@property (unsafe_unretained, nonatomic) IBOutlet UIBarButtonItem *MenuButton;
- (IBAction)menuButtonClick:(id)sender;
@property (unsafe_unretained, nonatomic) IBOutlet UIView *MainView;
@property (unsafe_unretained, nonatomic) IBOutlet UITableView *MenuTable;
@property (unsafe_unretained, nonatomic) IBOutlet UINavigationItem *MenuTitle;
@property (unsafe_unretained, nonatomic) IBOutlet UINavigationItem *MainTitle;


@end
