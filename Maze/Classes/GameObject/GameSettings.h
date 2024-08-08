//
//  GameSettings.h
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface GameSettings : NSObject <NSCoding>
{
	BOOL soundEffectsStatus;
	BOOL ambientSoundStatus;
	BOOL accelerometerStatus;
    BOOL manualStatus;
    
    NSString *playerName;
    
    int themeNo;
    NSString *selectedTheme;
}

+(GameSettings*) sharedGameSettings;

@property (readwrite) BOOL soundEffectsStatus;
@property (readwrite) BOOL ambientSoundStatus;


@property (readwrite) BOOL accelerometerStatus;
@property (readwrite) BOOL manualStatus;

@property (nonatomic, retain) NSString *playerName;

@property (readwrite) int themeNo;
@property (nonatomic, retain) NSString *selectedTheme;

@end
