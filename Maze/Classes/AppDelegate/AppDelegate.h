//
//  AppDelegate.h
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;
@property (nonatomic, retain) RootViewController *viewController;

+ (NSString *) pathForApplicationFile: (NSString *) name;

@end
