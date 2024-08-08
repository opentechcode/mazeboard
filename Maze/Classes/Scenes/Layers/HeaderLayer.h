//
//  HeaderLayer.h
//  Maze
//
//  Created by Ali Imran on 6/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HeaderLayer : CCLayer {
    
    CCSprite *background;
    CCSprite *headingSprite;
    CCSprite *headerBar;
}


@property (nonatomic, retain) CCSprite *background;
@property (nonatomic, retain) CCSprite *headingSprite;
@property (nonatomic, retain) CCSprite *headerBar;

- (id) initWithHeading: (NSString *) heading;


@end
