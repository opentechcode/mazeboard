//
//  MazeManager.h
//  Maze
//
//  Created by Ali Zafar on 5/9/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Cell.h"

@interface MazeManager : NSObject {
	
	NSMutableArray *cells;
	int cellsPerLine;
	int cellcount;
    
}

@property (nonatomic, retain)NSMutableArray *cells;
@property (nonatomic, readwrite)int cellsPerLine;


- (void) createCellsWithCellPerLine:(int)cellperline Width:(int)width Height:(int)height StartPoint:(CGPoint)startPoint;
- (NSMutableArray *) getNeighborsofCell:(int)cellNumber;
- (void) runBacktrackAlgorithm;
- (void) backTrackForCell:(int)cellNumber;

- (void) createLevel: (NSString *) level;
- (NSMutableArray *) getConnectorsDetails;

- (void) fillConnectorArray: (NSMutableArray *) connectors withType: (NSString *) type andPosX: (float) posX andPosY: (float) posY;

@end
