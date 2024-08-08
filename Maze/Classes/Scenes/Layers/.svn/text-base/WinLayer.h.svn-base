//
//  WinLayer.h
//  Maze
//
//  Created by Ali Imran on 6/23/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WinLayerProtocol.h"

@interface WinLayer : CCLayer <UITextFieldDelegate> {
    id <LayerProtcol> delegate;
    UITextField *nameTextField;
    
    
    CCMenuItemImage *btnSave;
}

@property (nonatomic, retain) id <LayerProtcol> delegate;
@property (nonatomic, retain) UITextField *nameTextField;
@property (nonatomic, retain) CCMenuItemImage *btnSave;


- (id) initWithTime:(int) seconds;
- (void) addTextBox:(NSString *) name;


- (id) initLostLayer;
- (id) initTiedLayer;

@end
