//
//  GameScene.h
//  Maze
//
//  Created by Ali Zafar on 4/28/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameLayer.h"

@interface GameScene : CCScene {

	
	GameLayer *gameLayer;
    
}

@property (nonatomic, retain)GameLayer *gameLayer;



@end
