//
//  Constant.h
//  iBattleships
//
//  Created by Ali Zafar on 9/29/10.
//  Copyright 2010 Vizio-Mobile Inc. All rights reserved.
//



/////////////////Font constants/////////////////////

#define CONST_FONT_TITLE_SIZE 22
#define CONST_FONT_SIZE 32
#define CONST_FONT_TEXT_SIZE 14
#define CONST_STRING_FONT_NAME @"Verdana-BoldItalic"


//////Cell Constants

#define CONST_CELL_VISITED_STATE_NOT_VISITED 0
#define CONST_CELL_VISITED_STATE_VISITED     1
#define CONST_CELL_VISITED_STATE_VISITED_COMPLETED 2

#define CONST_CELL_NEIGHBOR_BOTTOM 0
#define CONST_CELL_NEIGHBOR_RIGHT 1

#define CONST_CELL_NEIGHBOR_TOP 2
#define CONST_CELL_NEIGHBOR_LEFT 3


#define CONST_CELL_KEY_CELL @"cell"
#define CONST_CELL_KEY_NEIGHBOR @"neighbor"


///////////////////Server Communication////////////////////////////////

#pragma mark Server Communication

//#define CONST_URL_SERVER @"http://localhost:8888/iBattleShip_Server/"




//////////////////////////// Constants for Alerts Messages//////////////

#pragma mark Alert Messages

#define CONST_ALERT_NETWORK_UNAVAILABLE_TITLE @"Network Unavailable"
#define CONST_ALERT_NETWORK_UNAVAILABLE_MESSAGE @"Could not connect to internet"
#define CONST_ALERT_NETWORK_UNAVAILABLE_MESSAGE_RETRY @"Could not connect to the internet. Do you want to retry?"


#define CONST_ALERT_CONNECTING_TITLE @"Connecting......"
#define CONST_ALERT_CONNECTING_MESSAGE @"Please wait while we connect to the server"

#define CONST_ALERT_SERVER_NOT_FOUND_TITLE @"Server Not Found!"
#define CONST_ALERT_SERVER_NOT_FOUND_MESSAGE @"Could not connect to the server"
#define CONST_ALERT_SERVER_NOT_FOUND_MESSAGE_RETRY @"Could not connect to the server. Do you want to retry?"

#define CONST_IOS_VERSION_ERROR_TITLE @"Error!"
#define CONST_IOS_VERSION_ERROR_TEXT  @"Please upgrade your ios to 4.1 or above to use this feature"

/// Email Messages Constants/////////

#define EMAIL_SUBJECT    @"A fantastic iPad game"
#define EMAIL_MESSAGE    @"Hello!! \n\nI enjoyed playing Maze Board game from Envision Studios and thought you might like to try it as well.  Maze Board is an extremely additive game that challenges and stimulates our brain.\n\nMaze Board can also be played in multiplayer mode so we can play against each other.  \n\nDownload the Maze Board game now from Apple App Store."  




/////////////////////////// Constants for Heading //////////////////////

#pragma mark Heading

#define CONST_HEADING_X 768/2
//#define CONST_HEADING_Y 1024 - 38 - 30
#define CONST_HEADING_Y 1024 - 67 - 30

/////////////////////////// Constants for Header Bar //////////////////////

#pragma mark Header Bar 

#define CONST_HEADER_BAR_X 768/2
#define CONST_HEADER_BAR_Y 1024 - 117 - 38

//////////////// Constants for Main Menu Button ///////////////

#pragma mark Main Menu Button

#define CONST_MAINMENU_POSITION_X 768 - 160
#define CONST_MAINMENU_POSITION_Y 36


//////////////// Constants for Font Size ///////////////

#define FONT_SIZE  35.0

//////////////////////////////////////////////////////////



#pragma mark Wall width and height


#define CONST_VERTICAL_WALL_WIDTH_EASY 2.5
#define CONST_VERTICAL_WALL_HEIGHT_EASY 31

#define CONST_HORIZONTAL_WALL_WIDTH_EASY 25
#define CONST_HORIZONTAL_WALL_HEIGHT_EASY 2.5

////////wall orientation//////////

#define CONST_WALL_ORIENTATION_VERTICAL 0
#define CONST_WALL_ORIENTATION_HORIZONTAL 1

/////////

#pragma mark destination x & y

//#define CONST_DESTINATION_X 45
//#define CONST_DESTINATION_Y 840

#define CONST_DESTINATION_X 727
#define CONST_DESTINATION_Y 97


/////////

#pragma mark Ball x & y

#define CONST_BALL_X 40
#define CONST_BALL_Y 900

////////


#pragma mark Game Type

#define CONST_GAME_TYPE_AUTO 0
#define CONST_GAME_TYPE_MANUAL 1

#define CONST_GAME_LEVEL_EASY 1
#define CONST_GAME_LEVEL_MEDIUM 2
#define CONST_GAME_LEVEL_HARD 3



//////

#pragma mark MultiPlayer Game Types

#define CONST_WIFI_SESSION_ID @"iPadMaza"

#define CONST_MULTIPLAYER_GAME_TYPE_LOCALWIFI 0

#define CONST_MULTIPLAYER_GAME_TYPE_GAMECENTER 1


#define CONST_MULTIPLAYER_GAME_MODE_ACCELEROMETER 0
#define CONST_MULTIPLAYER_GAME_MODE_DRAG 1


//////////Message Types//////////

#pragma mark Message Types

#define CONST_MESSAGE_TYPE_HAND_SHAKE 0

#define CONST_MESSAGE_TYPE_START_GAME_PLAY 1
#define CONST_MESSAGE_TYPE_MOVE_PLAYER 2

#define CONST_MESSAGE_TYPE_LEAVE_MATCH 3

#define CONST_MESSAGE_TYPE_START_HARD_GAME 4

#define CONST_MESSAGE_TYPE_GAME_WIN 5
#define CONST_MESSAGE_TYPE_GAME_LOST 6

#define CONST_MESSAGE_TYPE @"message_type"


//////////////// Constants for Game State ///////////////

#pragma mark Game States


#define CONST_GAME_STATE_REMOTE_PLAYER_SELECTED 1
#define CONST_GAME_STATE_LOCAL_PLAYER_SELECTED 2
#define CONST_GAME_STATE_BOTH_SELECTED 3
#define CONST_GAME_STATE_LOCAL_PLAYER_TURN 4
#define CONST_GAME_STATE_REMOTE_PLAYER_TURN 5
#define CONST_GAME_STATE_END 6

#define CONST_GAME_STATE_INITIALIZE 0
#define CONST_GAME_STATE_WON 1
#define CONST_GAME_STATE_LOST 2
#define CONST_GAME_STATE_TIED 3


/////////////Keys/////////////////

#pragma mark Keys

#define CONST_KEY_GAME_START_TIME @"gameStartTime"
#define CONST_KEY_MAZE @"maze"
#define CONST_KEY_BALL_POS_X @"posX"
#define CONST_KEY_BALL_POS_Y @"posY"

#define CONST_KEY_GAME_LEVEL @"level"
#define CONST_KEY_GAME_MODE @"mode"

#define CONST_KEY_MESSAGE_NUMBER @"messageNo"

#define CONST_ABOUT_TEXT @"Maze Board is a puzzle game in the form of a complex branching passage through which the solver must find a route. Maze denotes a complex and confusing series of pathways.  The pathways and walls in a Maze are dynamic and the complexity of the Maze depends on the difficulty level selected.\n\nMaze solving is the act of finding a route through the Maze from the start to finish in the least possible time.\n\nMaze Board also offers multi-player mode.  In the multi-player mode, two players compete with each other to complete the Maze in the least possible time.  The player who completes the Maze first wins.  \n\nA local and global leaderboard maintains the list of top players both on the device as well as globally. "


#define CONST_MULTIPLAYER_TEXT @"Note: In order to play on Local Network or Auto Match in Game Center, both players must choose same control and difficulty level."


