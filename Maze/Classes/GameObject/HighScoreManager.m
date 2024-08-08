//
//  HighScoreManager.m
//  Maze
//
//  Created by Ali Imran on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "HighScoreManager.h"
#import "HighScore.h"
#import "AppDelegate.h"

@implementation HighScoreManager

@synthesize easyAccelerometer, mediumAccelerometer, hardAccelerometer, easyDrag, hardDrag, mediumDrag;


- (id) init
{
    self = [super init];
    
    if (self != nil) {
        
        NSMutableArray *temp = [[NSMutableArray alloc] init];
        self.easyAccelerometer = temp;
        [temp release];
        
        
        NSMutableArray *temp1 = [[NSMutableArray alloc] init];
        self.mediumAccelerometer = temp1;
        [temp1 release];
        
        
        NSMutableArray *temp2 = [[NSMutableArray alloc] init];
        self.hardAccelerometer = temp2;
        [temp2 release];
        
        
        NSMutableArray *temp3 = [[NSMutableArray alloc] init];
        self.easyDrag = temp3;
        [temp3 release];
        
        
        NSMutableArray *temp4 = [[NSMutableArray alloc] init];
        self.mediumDrag = temp4;
        [temp4 release];
        
        
        NSMutableArray *temp5 = [[NSMutableArray alloc] init];
        self.hardDrag = temp5;
        [temp5 release];
        
        
        [self loadAllScores];
        
    }
    
    return self;
}

#pragma mark Score Saving and Loading Methods


- (void) saveAllScores 
{
    
    [self saveScoresArray:self.easyAccelerometer fileName:@"easyAccelerometer"];
    [self saveScoresArray:self.mediumAccelerometer fileName:@"mediumAccelerometer"];
    [self saveScoresArray:self.hardAccelerometer fileName:@"hardAccelerometer"];
    
    [self saveScoresArray:self.easyDrag fileName:@"easyDrag"];
    [self saveScoresArray:self.mediumDrag fileName:@"mediumDrag"];
    [self saveScoresArray:self.hardDrag fileName:@"hardDrag"];
}

- (void) saveScoresArray:(NSMutableArray *)scores fileName:(NSString *)fileName
{
    [self sortScoresArray:scores];
    
    if ([NSKeyedArchiver archiveRootObject:scores toFile:[AppDelegate pathForApplicationFile:[NSString stringWithFormat:@"%@", fileName]]]) {
		
		//NSLog(@"%@ score saved", fileName);
	} else {
		NSLog(@"%@ score could not be saved", fileName);
	}
}


- (NSMutableArray *) loadScoresArray:(NSMutableArray *) scores fileName:(NSString *) fileName
{
    NSMutableArray *tempArray = [NSKeyedUnarchiver unarchiveObjectWithFile:[AppDelegate pathForApplicationFile:[NSString stringWithFormat:@"%@", fileName]]];
    
    if (tempArray != nil) {
        scores = tempArray;
    }
    [self sortScoresArray:scores];
    
    return scores;
}


- (void) loadAllScores
{
    self.easyAccelerometer = [self loadScoresArray:self.easyAccelerometer fileName:@"easyAccelerometer"];
    self.mediumAccelerometer = [self loadScoresArray:self.mediumAccelerometer fileName:@"mediumAccelerometer"];
    self.hardAccelerometer = [self loadScoresArray:self.hardAccelerometer fileName:@"hardAccelerometer"];
    
    self.easyDrag = [self loadScoresArray:self.easyDrag fileName:@"easyDrag"];
    self.mediumDrag = [self loadScoresArray:self.mediumDrag fileName:@"mediumDrag"];
    self.hardDrag = [self loadScoresArray:self.hardDrag fileName:@"hardDrag"];
    
}


#pragma mark Sort Array Methods

- (void) sortScoresArray: (NSMutableArray *) scores
{
    [scores sortUsingFunction:myCompareFunction context:nil];
    
    int counter = [scores count];
    
    for (int i = counter; i > 10 ; i--) {
        [scores removeObjectAtIndex:i - 1];
    }
    
}



int myCompareFunction( id obj1, id obj2, void *context )
{
	HighScore *compareObject1 = (HighScore *) obj1;
	HighScore *compareObject2 = (HighScore *) obj2;
	
    if(compareObject1.time <  compareObject2.time) {
		return NSOrderedAscending;
	} else if(compareObject1.time>  compareObject2.time) {
		return NSOrderedDescending;
	}
	return NSOrderedSame;
	
}


- (void) dealloc
{
    [easyAccelerometer release];
    [meduimAccelerometer release];
    [hardAccelerometer release];
    
    [easyDrag release];
    [meduimDrag release];
    [hardDrag release];
    
    [super dealloc];
}


@end
