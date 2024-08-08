//
//  GameSettings.m
//  Maze
//
//  Created by Ali Imran on 5/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GameSettings.h"


static GameSettings *sharedGameSettings = nil;

@implementation GameSettings

@synthesize soundEffectsStatus, ambientSoundStatus, accelerometerStatus, manualStatus, playerName, themeNo, selectedTheme;

+(GameSettings*) sharedGameSettings
{
    @synchronized(self) {
        
        if (sharedGameSettings == nil) {
			
            sharedGameSettings = [[self alloc] init];
            
		}
        
    }
    
    return sharedGameSettings;
    
}
- (id) init
{
	self = [super init];
	if (self != nil)  {
		self.soundEffectsStatus = YES;
		self.ambientSoundStatus = YES;
        self.accelerometerStatus = YES;
        self.manualStatus = NO;
        self.themeNo = 0;
        
        NSString *temp = [[NSString alloc] init];
        self.playerName = temp;
        [temp release];
        
        NSString *theme = [[NSString alloc] init];
        self.selectedTheme = theme;
        [theme release];
        
	}
	return self;
}

- (id) initWithCoder:(NSCoder *) coder
{
	
	self = [super init];
	if (self != nil) {
		self.soundEffectsStatus = [[coder decodeObjectForKey:@"soundEffectsStatus"] boolValue];
		self.ambientSoundStatus = [[coder decodeObjectForKey:@"ambientSoundStatus"] boolValue];
        self.accelerometerStatus = [[coder decodeObjectForKey:@"accelerometerStatus"] boolValue];
        self.manualStatus = [[coder decodeObjectForKey:@"manualStatus"] boolValue];
        self.playerName = [coder decodeObjectForKey:@"playerName"];
        self.themeNo = [[coder decodeObjectForKey:@"themeNo"] intValue];
        self.selectedTheme = [coder decodeObjectForKey:@"selectedTheme"];
    }
    return self;
}


- (void) encodeWithCoder: (NSCoder *) coder
{
	[coder encodeObject:[NSNumber numberWithBool:self.soundEffectsStatus] forKey:@"soundEffectsStatus"];
	[coder encodeObject:[NSNumber numberWithBool:self.ambientSoundStatus] forKey:@"ambientSoundStatus"];
    [coder encodeObject:[NSNumber numberWithBool:self.accelerometerStatus] forKey:@"accelerometerStatus"];
    [coder encodeObject:[NSNumber numberWithBool:self.manualStatus] forKey:@"manualStatus"];
    [coder encodeObject:self.playerName forKey:@"playerName"];
    [coder encodeObject:[NSNumber numberWithInt:self.themeNo] forKey:@"themeNo"];
    [coder encodeObject:self.selectedTheme forKey:@"selectedTheme"];
}



- (void) dealloc
{
	[playerName release];
    [selectedTheme release];
	[super dealloc];
}

@end
