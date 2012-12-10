//

// 
//
//  Created by Jesse MacFadyen on 10-05-29.
//  Copyright 2010 Nitobi. All rights reserved.
//

#import "ChildBrowserCommand.h"

#import <Cordova/CDVViewController.h>


@implementation ChildBrowserCommand

@synthesize childBrowser;

- (void) showWebPage:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{	
	if(childBrowser == NULL)
	{
		childBrowser = [[ ChildBrowserViewController alloc ] initWithScale:FALSE ];
		childBrowser.delegate = self;
	}
	
/* // TODO: Work in progress
	NSString* strOrientations = [ options objectForKey:@"supportedOrientations"];
	NSArray* supportedOrientations = [strOrientations componentsSeparatedByString:@","];
*/

    CDVViewController* cont = (CDVViewController*)[super viewController];
    [childBrowser setSupportedOrientations:(NSArray *)cont.supportedInterfaceOrientations];
    [cont presentModalViewController:childBrowser animated:YES];
    
    NSString *url = (NSString*) [arguments objectAtIndex:0];
    
    [childBrowser loadURL:url  ];

}

-(void) close:(NSMutableArray*)arguments withDict:(NSMutableDictionary*)options // args: url
{
	[ childBrowser closeBrowser];
	
}

-(void) onClose
{
	NSString* jsCallback = @"ChildBrowser._onClose();";
	[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
}

-(void) onOpenInSafari
{
	NSString* jsCallback = @"ChildBrowser._onOpenExternal();";
	[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];
}


-(void) onChildLocationChange:(NSString*)newLoc
{
	
	NSString* tempLoc = [NSString stringWithFormat:@"%@",newLoc];
	NSString* encUrl = [tempLoc stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	 
	NSString* jsCallback = [NSString stringWithFormat:@"ChildBrowser._onLocationChange('%@');",encUrl];
	[self.webView stringByEvaluatingJavaScriptFromString:jsCallback];

}




@end
