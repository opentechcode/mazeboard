//
//  HighScore.h
//  Maze
//
//  Created by Ali Imran on 6/27/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HighScore : NSObject <NSCoding> {
    
    NSString *name;
    int time;
}

@property (nonatomic, retain) NSString *name;
@property (readwrite) int time;

- (HighScore *) initwithName: (NSString *) scorername Time:(int)scorertime;
- (HighScore *) initwithDictionary:(NSDictionary *) dict;



@end
