//
//  TwitterManager.m
//  Maze
//
//  Created by Ali Zafar on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TwitterManager.h"

#import "TwitterViewController.h"
#define TWITTER_FEED @"http://m.twitter.com/envisiongames"

#define kOAuthConsumerKey				@"RpdEycA7j36siSKNkRqaBg"		//REPLACE ME
#define kOAuthConsumerSecret			@"NOOyYiJ6cW5s7KswxywocAJiJv2sFvrJzlNmjrJ7v4"		//REPLACE ME
#define statusString @"Just Installed and started playing Maze Board from Envision Studios. http://www.envisionstudios.biz"

@implementation TwitterManager
@synthesize twitterFeed,closeButton,engine;

- (id) init
{
	self = [super init];
	if (self != nil) {
		twitterDisplaycount=0;
	}
	return self;
}

#pragma mark update status in twitter

-(void)twitterUpdateStatus
{

	NSString *twitterData=[self loadOauthData];
	
	if (!twitterData) {
		
		[self setUpTwitter];
	
	}else {
		
		[self showEnvisionStudiosFeed];
		//NSLog(@"Posting to twitter");
		//[self.engine sendUpdate:statusString];
		
	}

}

-(void)setUpTwitter
{
	self.engine = [[[SA_OAuthTwitterEngine alloc] initOAuthWithDelegate: self] autorelease];
	self.engine.consumerKey =kOAuthConsumerKey;
	self.engine.consumerSecret= kOAuthConsumerSecret;
 
	UIViewController *controller = [SA_OAuthTwitterController controllerToEnterCredentialsWithTwitterEngine: self.engine delegate: self];
	
	if (controller) 
	{
		[[(AppDelegate *)[UIApplication sharedApplication].delegate viewController] presentModalViewController:controller animated:YES];
		//AppDelegate *appDelegate= (AppDelegate *)[UIApplication sharedApplication].delegate;
	
		//UIViewController *viewController=(UIViewController *) appDelegate.viewController;
	
		//[viewController.navigationController presentModalViewController: controller animated: YES];
	
	}	
		
	
}

#pragma mark Show feeds methods
-(void)showEnvisionStudiosFeed
{
	if (twitterDisplaycount>0) {
		return;
	}
	twitterDisplaycount+=1;
	self.twitterFeed=[[UIWebView alloc] initWithFrame:CGRectMake(36, 112, 690, 800)];
	[twitterFeed setOpaque:NO];
	[twitterFeed setBackgroundColor:[UIColor grayColor]];
	[twitterFeed setDelegate:self];
	
	self.closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
	
	CGRect frame = CGRectMake(710, 95, 33, 33);
	
	
	
	closeButton.frame = frame;
	
	UIImage *snap_picture = [UIImage imageNamed:@"close.png"];
	
	[closeButton setBackgroundImage:snap_picture forState:UIControlStateNormal];
	[closeButton setBackgroundImage:snap_picture forState:UIControlStateSelected];
	
	closeButton.userInteractionEnabled = YES;
	
	[closeButton addTarget:self action:@selector(closePressed:) forControlEvents:UIControlEventTouchUpInside];
    
	
	 UIViewController *controller= (UIViewController *)  [(AppDelegate *)[UIApplication sharedApplication].delegate viewController];
	
	
		
	NSString *urlAddress = TWITTER_FEED;
	NSURL *url = [NSURL URLWithString:urlAddress];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	twitterFeed.scalesPageToFit = YES;
	
	[twitterFeed loadRequest:requestObj];

	
	[controller.view addSubview:twitterFeed];	

	[controller.view addSubview:closeButton];
	
	[self showActivityIndicator];
	
	
}


-(void)hideTwitterViewController
{
	twitterDisplaycount-=1;
	[twitterFeed removeFromSuperview];
	[closeButton removeFromSuperview];
	[twitterFeed release];
	//[closeButton release];
	twitterFeed=nil;
	closeButton=nil;
}

-(void)closePressed:(id)sender
{
	[self hideTwitterViewController];
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

#pragma mark Authentacation data saved and load methods

-(NSString *)loadOauthData
{
    return [[NSUserDefaults standardUserDefaults] objectForKey: @"authData"];
   // return self.ouathData;
}

-(void)saveOauthData:(NSString *)data
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	//[str dataUsingEncoding:[NSString defaultCStringEncoding]];
	[defaults setObject: data forKey: @"authData"];
	[defaults synchronize];


}



#pragma mark SA_OAuthTwitterEngine Controller Delegate methods

- (void) OAuthTwitterController: (SA_OAuthTwitterController *) controller authenticatedWithUsername: (NSString *) username
{
	
	
	NSLog(@"Authenicated for %@", username);
    [self.engine enableUpdatesFor:@"EnvisionStd"];
    //now continue with posting
	[self.engine sendUpdate:statusString];
	
	
	[Utility showAlertViewWithTitle:@"Thanks" andMessage:@"Now you are with us on Twitter!"];
	[self performSelector:@selector(showEnvisionStudiosFeed) withObject:nil afterDelay:5.0];
	// [self twitterUpdateStatus:statusString];
	
	
}
- (void) OAuthTwitterControllerFailed: (SA_OAuthTwitterController *) controller
{
	NSLog(@"Authentication failed");
		
}


- (void) OAuthTwitterControllerCanceled: (SA_OAuthTwitterController *) controller
{
	
	NSLog(@"Authentication canceled");

}
- (void) storeCachedTwitterOAuthData: (NSString *) data forUsername: (NSString *) username {
	
    [self saveOauthData:data];
    
}

- (NSString *) cachedTwitterOAuthDataForUsername: (NSString *) username {
    return [self loadOauthData];
}




#pragma mark TwitterEngineDelegate
- (void) requestSucceeded: (NSString *) requestIdentifier {
	NSLog(@"Request %@ succeeded", requestIdentifier);
    	
}

- (void) requestFailed: (NSString *) requestIdentifier withError: (NSError *) error {
	
    NSLog(@"Request %@ failed with error: %@", requestIdentifier, error);
    
	
    
}

#pragma mark Activity Indicator

-(void)showActivityIndicator
{
	activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	activityIndicator.frame = CGRectMake(768/2, 1024/2, 30, 30);
//	self.frame = CGRectMake(0, 0, 320, 480);
//	self.backgroundColor = [UIColor colorWithRed:(180.0/255.0) green:(180.0/255.0) blue:(180.0/255.0) alpha:0.5];
//	self.alpha = 0.9;
//	[self addSubview:activityIndicator];
	
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

-(void) dealloc
{
	[twitterFeed release];
	//[closeButton release];
	[super dealloc];
}
@end
