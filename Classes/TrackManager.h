//
//  MatchManager.h
//  MatchKana
//
//  Created by Marin Todorov on 12/29/10.
//  Copyright 2010 Marin Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MatchGameConfig.h"
#import "TileSprite.h"

#import "SimpleAudioEngine.h"
#import "TileSpriteDelegateProtocol.h"

@interface TrackManager : NSObject<TileSpriteDelegateProtocol> {
	
	NSArray* tileNames;
	
	CCSprite* tileBack;
	
	NSMutableArray* openTiles;
	
	CCMenu* tileSet;
	
	int numOpenTiles;
	
	CCSprite* winText;
	CCMenu* menuWin;
	
	BOOL isTileLabelVisible;
	
	BOOL dispatchTouches;
}

@property (nonatomic, retain) NSArray* tileNames;
@property (nonatomic, retain) CCSprite* tileBack;
@property (nonatomic, retain) NSMutableArray* openTiles;
@property (nonatomic, retain) CCMenu* tileSet;

@property (assign, readwrite) int numOpenTiles;

@property (retain, nonatomic) CCSprite* winText;
@property (retain, nonatomic) CCMenu* menuWin;


-(void)load;
-(void)didOpenTile:(TileSprite*)tile;
-(void)unloadTileSet;
-(void)showWinAnimation;
-(void)toggleLabelVisibility;
-(void)setDispatchTouches:(BOOL)does;

@end
