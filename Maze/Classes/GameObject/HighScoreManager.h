//
//  HighScoreManager.h
//  Maze
//
//  Created by Ali Imran on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighScoreManager : NSObject {
    
    NSMutableArray *easyAccelerometer;
    NSMutableArray *meduimAccelerometer;
    NSMutableArray *hardAccelerometer;
    
    
    NSMutableArray *easyDrag;
    NSMutableArray *meduimDrag;
    NSMutableArray *hardDrag;
    
}

@property (nonatomic, retain) NSMutableArray *easyAccelerometer;
@property (nonatomic, retain) NSMutableArray *mediumAccelerometer;
@property (nonatomic, retain) NSMutableArray *hardAccelerometer;

@property (nonatomic, retain) NSMutableArray *easyDrag;
@property (nonatomic, retain) NSMutableArray *mediumDrag;
@property (nonatomic, retain) NSMutableArray *hardDrag;



- (void) saveAllScores;
- (void) loadAllScores;

- (void) saveScoresArray:(NSMutableArray *) scores fileName:(NSString *) fileName;
- (NSMutableArray *) loadScoresArray:(NSMutableArray *) scores fileName:(NSString *) fileName;


int myCompareFunction( id obj1, id obj2, void *context );
- (void) sortScoresArray: (NSMutableArray *) scores;

@end
