//
//  GameCenter.m
//  BattleshipiPhone
//
//  Created by Ali Zafar on 12/22/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "GameCenter.h"
#import "AppDelegate.h"

@implementation GameCenter
@synthesize scores, isPlayerAuthenticated, multiplayerManager, isInvited;

- (id) init
{
	self = [super init];
    
	if (self != nil) {
		
		isPlayerAuthenticated = NO;
        isInvited = NO;
        
        /*
         NSMutableArray *temp=[[NSMutableArray alloc] init];
         self.scores=temp;
         [temp release];
        */
        
        MultiplayerManager *temp = [[MultiplayerManager alloc] init];
        self.multiplayerManager = temp;
        [temp release];
        
		[self loadScores];
		
	}
	return self;
}

- (void) registerInviteHandler
{
	[GKMatchmaker sharedMatchmaker].inviteHandler = ^(GKInvite *acceptedInvite, NSArray *playersToInvite) {
		// Insert application-specific code here to clean up any games in progress.
		
        if (acceptedInvite) {
            
            isInvited = YES;
			GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithInvite:acceptedInvite] autorelease];
			mmvc.matchmakerDelegate = self;
			
			[[(AppDelegate *)[UIApplication sharedApplication].delegate viewController] presentModalViewController:mmvc animated:YES];;
			
		} else if (playersToInvite) {
			/*
			 GKMatchRequest *request = [[[GKMatchRequest alloc] init] autorelease];
			 request.minPlayers = 2;
			 request.maxPlayers = 4;
			 request.playersToInvite = playersToInvite;
			 
			 GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithMatchRequest:request] autorelease];
			 mmvc.matchmakerDelegate = self;
			 [self presentModalViewController:mmvc animated:YES];
			 */
		}
	};
}



#pragma mark Load Scores

- (void) loadScores
{
	NSMutableArray *tempArray=[NSKeyedUnarchiver unarchiveObjectWithFile:[AppDelegate pathForApplicationFile:@"gamecenterscores"]];
	
	if (tempArray != nil) {
		
		self.scores=tempArray;
		[scores retain]; 
        
	} else {
		
		tempArray=[[NSMutableArray alloc] init];
		self.scores=tempArray;
		[scores retain];
		[tempArray release];
        
	}
}


- (void) saveScores
{
	
    if ([NSKeyedArchiver archiveRootObject:scores toFile:[AppDelegate pathForApplicationFile:@"gamecenterscores"]]) {
		NSLog(@"Score saved");
	} else {
		NSLog(@"Score Could not be saved");
	}
	
}



#pragma mark Authentications
- (void) autheticatePlayer
{
	GKLocalPlayer *localPlayer=[GKLocalPlayer localPlayer];
	[localPlayer authenticateWithCompletionHandler:^(NSError *error) {
		
		if (!error) {
			NSLog(@"Featured Enabled");
			NSLog(@"%@", localPlayer.alias);
			isPlayerAuthenticated = YES;
			[self registerInviteHandler];
			[self reportOutStandingScore];
		} else {
			NSLog(@"Featured Disabled");
			isPlayerAuthenticated = NO;
		}
	}
     
	 ];
	
}


-(void)registerForAuthenticationNotification
{
	NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
	[nc addObserver:self selector:@selector(authentiacationChanged:) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
}


- (void) authentiacationChanged:(id) sender
{
    
	if ([[GKLocalPlayer localPlayer] isAuthenticated]) {
		isPlayerAuthenticated = YES;
	} else {
		isPlayerAuthenticated = NO;
	}
    
}




#pragma mark Score Reporting Methods 

- (void) reportOutStandingScore
{
	if ([scores count] == 0) {
		return;
	}
	
	NSDictionary *dict=[scores objectAtIndex:0];
	
	NSString *category=[dict objectForKey:@"category"];
	
	NSNumber *number=[dict objectForKey:@"score"];
	
	GKScore *playerScore= [[[GKScore alloc] initWithCategory:category] autorelease];
	playerScore.value= [number intValue];
	//playerScore.rank=seconds;
	
	[playerScore reportScoreWithCompletionHandler:^(NSError *error){
		
		if (!error) {
			if ([scores count]!=0) {
                //	[[ServerCommunicationManager sharedServerCommunicationmanager] submitScore:[number intValue] LeaderName:leaderName];
				[scores removeObjectAtIndex:0];
			}
		} else {
			NSLog(@"%@",error);
			// do nothing
		}
		
	}
	 
	 ];
}

- (void) reportTheScore:(int)shots Category:(NSString *) category 
{
	if ([[GKLocalPlayer localPlayer] isAuthenticated]) {
		
		GKScore *playerScore= [[[GKScore alloc] initWithCategory:category] autorelease];
		playerScore.value=shots;
		//playerScore.rank=seconds;
		
		[playerScore reportScoreWithCompletionHandler:^(NSError *error){
			
			if (!error) {
				NSLog(@"%@",error);
				//score submitted successfully
				//[[ServerCommunicationManager sharedServerCommunicationmanager] submitScore:shots LeaderName:leaderName];
			}
			else {
				NSLog(@"%@",error);
				NSDictionary *dict=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:category,[NSNumber numberWithInt:shots],nil] forKeys:[NSArray arrayWithObjects:@"category",@"score",nil]];
				[scores addObject:dict];
				[self saveScores];
			}
			
			
		}
		 
		 
		 
		 ];
		
		
	}
	else {
		[self authenticatePlayerToSubmitScore:shots Category:category];
	}
    
	
    
	//score.value=
	
}

-(void)authenticatePlayerToSubmitScore:(int)myscore Category:(NSString *)category
{
	
	GKLocalPlayer *localPlayer=[GKLocalPlayer localPlayer];
	[localPlayer authenticateWithCompletionHandler:^(NSError *error){
		
		if (!error) {
			NSLog(@"Featured Enabled");
			NSLog(@"%@",localPlayer.alias);
			isPlayerAuthenticated=YES;
			[self registerInviteHandler];
			[self reportTheScore:myscore Category:category];
		}
		else {
			NSLog(@"Featured Disabled");
			isPlayerAuthenticated=NO;
			NSDictionary *dict=[NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:category,[NSNumber numberWithInt:myscore],nil] forKeys:[NSArray arrayWithObjects:@"category",@"score",nil]];
			[scores addObject:dict];
			[self saveScores];
            
		}
		
		
	}
	 
	 
	 ];
	
    
    
	
	
}


#pragma mark Showing Controller
//////////////////////////////////


-(void)showViewControllerLeaderBoard
{
	if (!isPlayerAuthenticated) {
		//UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"GameCenter Disabled" message:@"You are currenly not logged in to the game center" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
		//[alertView show];
		[self authenticatePlayerToShowLearderBoard];
	    return;
	}
	
	GKLeaderboardViewController* myLeaderboardViewController = [[[GKLeaderboardViewController alloc] init] autorelease];
    
	
    //	myLeaderboardViewController.timeScope=GKLeaderboardTimeScopeAllTime;
	myLeaderboardViewController.leaderboardDelegate=self;
	
	//[myLeaderboardViewController.view setFrame:CGRectMake(0, 0, 1024, 768)];
	
	[[(AppDelegate *)[UIApplication sharedApplication].delegate viewController] presentModalViewController:myLeaderboardViewController animated:YES];;
    
	
	
	//[myLeaderboardViewController set]
	//[myLeaderboardViewController setLeaderboardDelegate: self];
	
	//[self presentModalViewController: myLeaderboardViewController];;
    
    
    
}


-(void)authenticatePlayerToShowLearderBoard
{
	//alertview=[Utility alertViewWithActivityIndicatorWithTitle:CONST_ALERT_CONNECTING_TITLE andMessage:CONST_ALERT_CONNECTING_MESSAGE];
    
	GKLocalPlayer *localPlayer=[GKLocalPlayer localPlayer];
	[localPlayer authenticateWithCompletionHandler:^(NSError *error){
        
		if (!error) {
			NSLog(@"Featured Enabled");
			NSLog(@"%@",localPlayer.alias);
			isPlayerAuthenticated=YES;
			[self registerInviteHandler];
			[self showViewControllerLeaderBoard];
			//[alertview dismissWithClickedButtonIndex:0 animated:YES];
			
			
		}
		else {
			NSLog(@"Featured Disabled");
			NSLog(@"Error:%@ ",error);
            //	[alertview dismissWithClickedButtonIndex:0 animated:YES];
			UIAlertView *alertView=[[UIAlertView alloc] initWithTitle:@"Login Failed" message:@"We are unable to log you into Game Center. Please check your network settings or try logging in directly from the Game Center application." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
			[alertView show];
			[alertView release];
			isPlayerAuthenticated=NO;
            
			
		}
		
		
	}
	 
	 
	 ];
	
	
	
	
	
}


- (void)leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController
{
	[[(AppDelegate *)[UIApplication sharedApplication].delegate viewController] dismissModalViewControllerAnimated:YES];
    
	
}

///////////////////////////////////////////////////////////

#pragma mark AutoMatching methods

-(void) launchAutoMatchingWithLevelType: (int) level;
{
	GKMatchRequest *matchRequest = [[GKMatchRequest alloc] init];
	matchRequest.minPlayers = 2;
	matchRequest.maxPlayers = 2;
	matchRequest.playerGroup = level;
	//matchRequest.playerAttributes=1;
	GKMatchmakerViewController *mmvc = [[[GKMatchmakerViewController alloc] initWithMatchRequest:matchRequest] autorelease];
	
	[[(AppDelegate *)[UIApplication sharedApplication].delegate viewController] presentModalViewController:mmvc animated:YES];
	
	
	mmvc.matchmakerDelegate = self;
	
	
}

- (void)matchmakerViewControllerWasCancelled:(GKMatchmakerViewController *)viewController
{
	[[(AppDelegate *)[UIApplication sharedApplication].delegate viewController] dismissModalViewControllerAnimated:YES];
	
}

- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFailWithError:(NSError *)error
{
	[[(AppDelegate *)[UIApplication sharedApplication].delegate viewController] dismissModalViewControllerAnimated:YES];
	
	NSLog(@"%@",error);
}


- (void)matchmakerViewController:(GKMatchmakerViewController *)viewController didFindMatch:(GKMatch *)match
{
	
    NSLog(@"Match Created");
    
    multiplayerManager.newMatch = match;
    multiplayerManager.newMatch.delegate = multiplayerManager;
    [[(AppDelegate*) [UIApplication sharedApplication].delegate viewController] dismissModalViewControllerAnimated:YES];
    [multiplayerManager startGame];
    
}


- (void) dealloc
{
	NSLog(@"GameCenter is Deallocing");
    [MultiplayerManager release];
	[scores release];
	[super dealloc];
}


@end
