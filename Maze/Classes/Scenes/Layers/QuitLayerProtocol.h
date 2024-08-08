//
//  QuitLayerProtocol.h
//  Maze
//
//  Created by Ali Imran on 8/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol QuitLayerProtocol <NSObject>

@required


- (void) removeGameQuitLayer:(int) tag;


@end
