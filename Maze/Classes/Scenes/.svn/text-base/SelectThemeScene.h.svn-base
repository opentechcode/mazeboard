//
//  SelectThemeScene.h
//  Maze
//
//  Created by Ali Imran on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HeaderLayer.h"

@interface SelectThemeScene : CCScene {
   
    HeaderLayer *headerLayer;
    
    
    CCMenuItemImage *btnNext;
    CCMenuItemImage *btnBack;
    NSMutableArray *toggleItems;
    NSString *gameLevel;
    
    
    
}

@property (nonatomic, retain) HeaderLayer *headerLayer;
@property (nonatomic, retain) NSMutableArray *toggleItems;
@property (nonatomic, retain) CCMenuItemImage *btnNext;
@property (nonatomic, retain) CCMenuItemImage *btnBack;

@property (nonatomic, retain) NSString *gameLevel;

- (id) initWithLevel: (NSString *) level;
- (void) drawToogleItems;

@end