//
//  FBManager.m
//  Maze
//
//  Created by Ali Imran on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FBManager.h"
#import "Constant.h"
#import "GameManager.h"

#define FACEBOOK_PAGE @"http://www.facebook.com/pages/Envision-Studios-Inc/200376043352155"

static NSString* kApiKey = @"256853620999782";


@implementation FBManager

@synthesize facebook, faceBookpage,closeButton;


- (id) init {
    self = [super init];
    
    if (self) {
        
        facebook = [[Facebook alloc] initWithAppId:kApiKey];
        faceBookPageDisplayCount=0;
		
		
        /*
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
            facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
            facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
        }
        
        if (![facebook isSessionValid]) {
            
            NSArray *permissions = [[NSArray arrayWithObjects:@"publish_stream", nil] retain];
            
            [facebook authorize:permissions delegate:self];
            
        }
		*/
        
    }
    return self;
}


-(void)authorizeFacebook
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
		facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
		facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
	}
	
	if (![facebook isSessionValid]) {
		
		NSArray *permissions = [[NSArray arrayWithObjects:@"publish_stream", nil] retain];
		
		[facebook authorize:permissions delegate:self];
		
	}
	
}
#pragma mark Post to Wall Helper
//  Maze Board is a puzzle game in the form of a complex branching passage through which the solver must find a route.

- (void) postToWall:(int) seconds andLevel: (NSString *) level
{
    
    NSString* fbName = [GameManager sharedGameManager].facebookName;
    
    NSString *nameString = [NSString stringWithFormat:@" "];
    
    NSString *captionString = [NSString stringWithFormat:@"%@ just completed the Maze in %d seconds.  You can download the game and challenge %@. Maze Board is a Free game from Envision Studios.", fbName, seconds, fbName];
    
    NSLog(@"%@", captionString);
    
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:@"",  @"description", @"http://envisionstudios.biz", @"link", @"http://www.envisionstudios.biz/mazeboard.png", @"picture", nameString, @"name", captionString, @"caption", nil];
    
    [facebook dialog:@"feed" andParams:params andDelegate:self];
    
}


#pragma mark FBSessionDelegate Method


- (void) fbDidLogin
{
    NSLog(@"fbDidLogin");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    if ([defaults objectForKey:@"FBAccessTokenKey"] && [defaults objectForKey:@"FBExpirationDateKey"]) {
        facebook.accessToken = [defaults objectForKey:@"FBAccessTokenKey"];
        facebook.expirationDate = [defaults objectForKey:@"FBExpirationDateKey"];
    }
    
    [defaults synchronize];
    
    [self getFacebookName];
    
    //if (![[GameManager sharedGameManager].facebookName isEqualToString:@""]) {
    //}
    
}



- (void) fbDidNotLogin:(BOOL) cancelled
{
    NSLog(@"fbDidNotLogin");
    
}



#pragma mark UIApplicationDelegate Method


- (BOOL) handleOpenUrl:(NSURL *) url
{
    return [facebook handleOpenURL:url];
}


#pragma mark FBDialogDelegate Methods

- (void)dialog:(FBDialog*)dialog didFailWithError:(NSError *)error
{
    //[self postToWall];
    
    NSLog(@"FBDialog didFailWithError");
}



#pragma mark Get Facebook Name Helper


- (void) getFacebookName
{
    
    NSLog(@"getFacebookName");
    
    [facebook requestWithGraphPath:@"me" andDelegate:self];
}



#pragma mark FBRequestDelegate Methods


- (void)request:(FBRequest *)request didReceiveResponse:(NSURLResponse *)response {
    NSLog(@"received response");
}


- (void)request:(FBRequest *)request didLoad:(id)result {
    NSLog(@"Inside didLoad");
    
    if ([result isKindOfClass:[NSArray class]]) {
        result = [result objectAtIndex:0];
    }
    
    // When we ask for user info this will happen.
    
    if ([result isKindOfClass:[NSDictionary class]]){
        
        NSLog(@"Name: %@", [result objectForKey:@"name"]);
        
        [GameManager sharedGameManager].facebookName = [result objectForKey:@"name"];
        [self postToWall:[GameManager sharedGameManager].finishTime andLevel:[GameManager sharedGameManager].difficultyLevel];
    }
    
}


- (void) request:(FBRequest *) request didFailWithError:(NSError *) error {
    NSLog(@"FBRequest *) request didFailWithError");
}


-(void)showEnvisionStudiosPage
{
	if (faceBookPageDisplayCount>0) {
		return;
	}
	
	faceBookPageDisplayCount+=1;
	
	self.faceBookpage=[[UIWebView alloc] initWithFrame:CGRectMake(36, 112, 690, 800)];
	[faceBookpage setOpaque:NO];
	[faceBookpage setBackgroundColor:[UIColor grayColor]];
	[faceBookpage setDelegate:self];
	
	self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	CGRect frame = CGRectMake(710, 95, 33, 33);
	
	
	
	closeButton.frame = frame;
	
	UIImage *snap_picture = [UIImage imageNamed:@"close.png"];
	
	[closeButton setBackgroundImage:snap_picture forState:UIControlStateNormal];
	[closeButton setBackgroundImage:snap_picture forState:UIControlStateSelected];
	
	closeButton.userInteractionEnabled = YES;
	
	[closeButton addTarget:self action:@selector(closePressed:) forControlEvents:UIControlEventTouchUpInside];
    
	
	UIViewController *controller= (UIViewController *)  [(AppDelegate *)[UIApplication sharedApplication].delegate viewController];
	
	
	
	NSString *urlAddress = FACEBOOK_PAGE;
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	faceBookpage.scalesPageToFit = YES;
	
	[faceBookpage loadRequest:requestObj];
	
	
	[controller.view addSubview:faceBookpage];	
	
	[controller.view addSubview:closeButton];
	
	[self showActivityIndicator];
	
	
}


-(void)hideFaceBookWebView
{
	faceBookPageDisplayCount-=1;
	[faceBookpage removeFromSuperview];
	[closeButton removeFromSuperview];
	[faceBookpage release];
	//[closeButton release];
	faceBookpage=nil;
	closeButton=nil;
}


#pragma mark Activity Indicator

-(void)showActivityIndicator
{
	activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.frame = CGRectMake(768/2, 1024/2, 30, 30);
		
	activityIndicator.backgroundColor = [UIColor clearColor];
	activityIndicator.autoresizingMask = (UIViewAutoresizingFlexibleLeftMargin |UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin |UIViewAutoresizingFlexibleBottomMargin);
	[activityIndicator startAnimating];
	
	UIViewController *controller= (UIViewController *)  [(AppDelegate *)[UIApplication sharedApplication].delegate viewController];
	
	[controller.view addSubview:activityIndicator];
	
}

-(void)hideActivityIndicator
{
	if (activityIndicator!=nil) {
		
		[activityIndicator stopAnimating];
		[activityIndicator removeFromSuperview];
		[activityIndicator release];
		activityIndicator=nil;
		
		
	}
}


-(void)closePressed:(id)sender
{
	[self hideFaceBookWebView];
	[self hideActivityIndicator];
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
	NSLog(@"Finish Load");
	[self hideActivityIndicator];
	//[self stopAactivityIndicator];
}


- (void) dealloc
{
    [facebook release];
    facebook = nil;
    [super dealloc];
}


@end
