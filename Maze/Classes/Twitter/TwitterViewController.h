//
//  TwitterViewController.h
//  Maze
//
//  Created by Ali Zafar on 8/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TwitterViewController : UIViewController <UIWebViewDelegate>{

	UIWebView *twitterFeed;
	int displayIndictorCount;
}

@property(nonatomic, retain)UIWebView *twitterFeed;



@end
