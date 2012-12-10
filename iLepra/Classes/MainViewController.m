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
//  Created by ___FULLUSERNAME___ on ___DATE___.
//  Copyright ___ORGANIZATIONNAME___ ___YEAR___. All rights reserved.
//

#import "MainViewController.h"

@implementation MainViewController
@synthesize MainView;
@synthesize MenuTable;
@synthesize MainTitle;
@synthesize SplashView;
@synthesize MainToolbar;
@synthesize MenuView;
@synthesize MenuButton;

CGPoint defaultCenter;
UIView* myWebView;

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];

    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillAppear:(BOOL)animated
{
    // Set the main view to utilize the entire application frame space of the device.
    // Change this to suit your view's UI footprint needs in your application.

    UIView* rootView = [[[[UIApplication sharedApplication] keyWindow] rootViewController] view];
    CGRect webViewFrame = [[[rootView subviews] objectAtIndex:0] frame];  // first subview is the UIWebView

    if (CGRectEqualToRect(webViewFrame, CGRectZero)) { // UIWebView is sized according to its parent, here it hasn't been sized yet
        self.view.frame = [[UIScreen mainScreen] applicationFrame]; // size UIWebView's parent according to application frame, which will in turn resize the UIWebView
    }

    [super viewWillAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // init menu tableview
    menuItems = [[NSMutableArray alloc] init];
    
    NSArray *mainSectionArray = [NSArray arrayWithObjects:@"Посты", @"Мои вещи", @"Инбокс", nil];
    NSDictionary *mainSectionDict = [NSDictionary dictionaryWithObject:mainSectionArray forKey:@"Основное"];
    
    NSArray *myStuffArray = [NSArray arrayWithObjects:@"Профиль", @"Избранное", @"Мои подлепры", nil];
    NSDictionary *myStuffDict = [NSDictionary dictionaryWithObject:myStuffArray forKey:@"Моё"];
    
    NSArray *lepraArray = [NSArray arrayWithObjects:@"Чятик", @"Блоги империи", @"Белый дом", nil];
    NSDictionary *lepraDict = [NSDictionary dictionaryWithObject:lepraArray forKey:@"Лепра"];
    
    NSArray *miscArray = [NSArray arrayWithObjects:@"Выход", nil];
    NSDictionary *miscDict = [NSDictionary dictionaryWithObject:miscArray forKey:@"Прочее"];
    
    [menuItems addObject:mainSectionDict];
    [menuItems addObject:myStuffDict];
    [menuItems addObject:lepraDict];
    [menuItems addObject:miscDict];
    
    [MenuTable setSeparatorColor:[UIColor darkGrayColor]];
    MenuTable.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    // init section picker
    pickerSections = [[NSMutableArray alloc] init];
    [pickerSections addObject:@"Главная"];
    [pickerSections addObject:@"Все подряд"];
    [pickerSections addObject:@"Подлепры"];
    
    defaultCenter = MainView.center;
    
    // add geture recognizer to title
    UITapGestureRecognizer *navSingleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(navSingleTap)];
    navSingleTap.numberOfTapsRequired = 1;
    [[MainToolbar.subviews objectAtIndex:1] setUserInteractionEnabled:YES];
    [[MainToolbar.subviews objectAtIndex:1] addGestureRecognizer:navSingleTap];
}

- (void)viewDidUnload
{
    [self setMenuView:nil];
    [self setMenuButton:nil];
    [self setMainView:nil];
    [self setMenuTable:nil];
    [self setMainTitle:nil];
    [self setSplashView:nil];
    [self setMainToolbar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return [super shouldAutorotateToInterfaceOrientation:interfaceOrientation];
}

/* Comment out the block below to over-ride */

/*
- (CDVCordovaView*) newCordovaViewWithFrame:(CGRect)bounds
{
    return[super newCordovaViewWithFrame:bounds];
}
*/

/* Comment out the block below to over-ride */

/*
#pragma CDVCommandDelegate implementation

- (id) getCommandInstance:(NSString*)className
{
    return [super getCommandInstance:className];
}

- (BOOL) execute:(CDVInvokedUrlCommand*)command
{
    return [super execute:command];
}

- (NSString*) pathForResource:(NSString*)resourcepath;
{
    return [super pathForResource:resourcepath];
}

- (void) registerPlugin:(CDVPlugin*)plugin withClassName:(NSString*)className
{
    return [super registerPlugin:plugin withClassName:className];
}
*/

#pragma UIWebDelegate implementation

- (void)webViewDidFinishLoad:(UIWebView*)theWebView
{
    myWebView = theWebView;
    
    // Black base color for background matches the native apps
    myWebView.backgroundColor = [UIColor blackColor];
    
    CGRect bounds = myWebView.frame;
    bounds.origin.y = 44;
    bounds.size.height -= 44;
    
    myWebView.frame = bounds;
    
    UIView* rootView = [[[[UIApplication sharedApplication] keyWindow] rootViewController] view];
    [rootView bringSubviewToFront:myWebView];
    [rootView bringSubviewToFront:SplashView];

    return [super webViewDidFinishLoad:theWebView];
}

/* Comment out the block below to over-ride */

/*

- (void) webViewDidStartLoad:(UIWebView*)theWebView
{
    return [super webViewDidStartLoad:theWebView];
}

- (void) webView:(UIWebView*)theWebView didFailLoadWithError:(NSError*)error
{
    return [super webView:theWebView didFailLoadWithError:error];
}

- (BOOL) webView:(UIWebView*)theWebView shouldStartLoadWithRequest:(NSURLRequest*)request navigationType:(UIWebViewNavigationType)navigationType
{
    return [super webView:theWebView shouldStartLoadWithRequest:request navigationType:navigationType];
}
*/

/*
 * TABLE STUFF
 */

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [menuItems count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //Number of rows it should expect should be based on the section
    NSDictionary *dictionary = [menuItems objectAtIndex:section];
    NSArray *array = [dictionary objectForKey:[[dictionary allKeys] objectAtIndex:0]];
    return [array count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSDictionary *dict = [menuItems objectAtIndex:section];
    return [[dict allKeys] objectAtIndex:0];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Set up the cell...
    
    //First get the dictionary object
    NSDictionary *dictionary = [menuItems objectAtIndex:indexPath.section];
    NSArray *array = [dictionary objectForKey:[[dictionary allKeys] objectAtIndex:0]];
    int ind = indexPath.row;
    NSString *cellValue = [array objectAtIndex:ind];
    cell.textLabel.text = cellValue;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    [cell setBackgroundColor:[UIColor blackColor]];
    cell.textLabel.textColor = [UIColor whiteColor];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.bounds.size.width, 24)];
    [headerView setBackgroundColor:[UIColor darkGrayColor]];
    
	// create the button object
	UILabel * headerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
	headerLabel.backgroundColor = [UIColor clearColor];
	headerLabel.opaque = NO;
	headerLabel.textColor = [UIColor whiteColor];
	headerLabel.highlightedTextColor = [UIColor lightGrayColor];
	headerLabel.font = [UIFont boldSystemFontOfSize:16];
	headerLabel.frame = CGRectMake(10.0, 0.0, (tableView.bounds.size.width - 10.0), 24.0);
    
	headerLabel.text = [[[menuItems objectAtIndex:section] allKeys] objectAtIndex:0];
	[headerView addSubview:headerLabel];
    
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString* row = (NSString *)[[[[menuItems objectAtIndex:indexPath.section] allValues] objectAtIndex:0] objectAtIndex:indexPath.row];
    
    [self toggleMenu];
    
    AppDelegate *myApp = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NativeUI* nUI = (NativeUI*)myApp.nativeUI;
    [nUI menuSelected:row];
}

/*
 * PICKER STUFF
 */


/*
 * OTHER STUFF
 */

- (IBAction)menuButtonClick:(id)sender {
    [self toggleMenu];
}

- (void)toggleMenu
{
    CGPoint center = MainView.center;
    CGPoint webcenter = myWebView.center;
    if( center.x == defaultCenter.x ){
        center.x = defaultCenter.x + 255;
        webcenter.x = defaultCenter.x + 255;
        self.webView.userInteractionEnabled = false;
    }else{
        center.x = defaultCenter.x;
        webcenter.x = defaultCenter.x;
        self.webView.userInteractionEnabled = true;
    }
    
    //NSLog(@"%@", bounds);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    MainView.center = center;
    myWebView.center = webcenter;
    [UIView commitAnimations];
}

-(void)navSingleTap
{
    NSLog(@"taptap");
    CGPoint topOffset = CGPointMake(0, 0);
    //[scrollView setContentOffset: topOffset animated: YES];
    [[[self.webView subviews] lastObject] setContentOffset:topOffset animated:YES];
}

@end
