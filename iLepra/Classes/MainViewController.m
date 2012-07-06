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

#import "MainViewController.h"

@implementation MainViewController
@synthesize MainView;
@synthesize MenuTable;
@synthesize MainTitle;
@synthesize SplashView;
@synthesize MainToolbar;
@synthesize MenuView;
@synthesize MenuButton;

- (id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //SectionPicker.hidden = true;
    }
    return self;
}

- (void) didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void) viewDidLoad
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
    
    // init section picker
    pickerSections = [[NSMutableArray alloc] init];
    [pickerSections addObject:@"Главная"];
    [pickerSections addObject:@"Все подряд"];
    [pickerSections addObject:@"Подлепры"];
}

- (void) viewDidUnload
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

- (BOOL) shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
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

- (void) webViewDidFinishLoad:(UIWebView*) theWebView 
{
    // only valid if ___PROJECTNAME__-Info.plist specifies a protocol to handle
    if (self.invokeString)
    {
        // this is passed before the deviceready event is fired, so you can access it in js when you receive deviceready
        NSString* jsString = [NSString stringWithFormat:@"var invokeString = \"%@\";", self.invokeString];
        [theWebView stringByEvaluatingJavaScriptFromString:jsString];
    }
    
    [theWebView removeFromSuperview];
    [MainView addSubview:theWebView]; 
     
    // Black base color for background matches the native apps
    theWebView.backgroundColor = [UIColor blackColor];
    
    CGRect bounds = theWebView.frame;
    bounds.origin.y = 44;
    bounds.size.height -= 44; 
    
    theWebView.frame = bounds;

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
    if( center.x == 160 ){
        center.x = 160 + 255;
        self.webView.userInteractionEnabled = false;
    }else{
        center.x = 160;
        self.webView.userInteractionEnabled = true;
    }
    
    //NSLog(@"%@", bounds);
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration: 0.25];
    MainView.center = center;
    [UIView commitAnimations];
}
@end
