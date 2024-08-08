//
//  FBManager.h
//  Maze
//
//  Created by Ali Imran on 8/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FBConnect.h"

@interface FBManager : NSObject <FBSessionDelegate, FBDialogDelegate, FBRequestDelegate,UIWebViewDelegate> {
    
    
    Facebook *facebook;
	UIWebView *faceBookpage;
    
	UIButton *closeButton;
	
	int faceBookPageDisplayCount;
	
	UIActivityIndicatorView *activityIndicator;
    
}

@property (nonatomic, retain) Facebook *facebook;
@property (nonatomic, retain)UIWebView *faceBookpage;

@property (nonatomic, retain)UIButton *closeButton;


-(void)authorizeFacebook;
- (BOOL) handleOpenUrl:(NSURL*) url;
- (void) postToWall:(int) seconds andLevel: (NSString *) level;
- (void) getFacebookName;

-(void)showEnvisionStudiosPage;

-(void)hideFaceBookWebView;
-(void)closePressed:(id)sender;

-(void)showActivityIndicator;
-(void)hideActivityIndicator;

@end
