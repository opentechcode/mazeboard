    //
//  TwitterViewController.m
//  Maze
//
//  Created by Ali Zafar on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterViewController.h"

#define TWITTER_FEED @"http://m.twitter.com/StepsAwayNews"

@implementation TwitterViewController
@synthesize twitterFeed;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
	
	[super loadView];
	
	displayIndictorCount=0;
	

	self.twitterFeed=[[UIWebView alloc] initWithFrame:CGRectMake(109, 112, 550, 800)];
	[twitterFeed setOpaque:NO];
	[twitterFeed setBackgroundColor:[UIColor clearColor]];
	[twitterFeed setDelegate:self];
	
	NSString *urlAddress = TWITTER_FEED;
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	twitterFeed.scalesPageToFit = YES;
	
	[twitterFeed loadRequest:requestObj];
	
	[self.view addSubview:twitterFeed];	
	
	

	

	
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark WebviewDelegate

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
	return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	//[NSThread detachNewThreadSelector:@selector(startActivityIndicator) toTarget:self withObject:nil];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	//[self stopAactivityIndicator];
}


- (void)dealloc {
    [super dealloc];
}


@end
