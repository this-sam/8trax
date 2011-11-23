//
//  TileSprite.h
//  MatchKana
//
//  Created by Marin Todorov on 12/29/10.
//  Copyright 2010 Marin Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "MatchGameConfig.h"
#import "CardFlipAction.h"

#import "TileSpriteDelegateProtocol.h"

@interface TileSprite : CCMenuItemImage {
	
	BOOL isOpen;
	BOOL isLabelVisible;
	
	NSString* fileName;
	
	CGPoint tilePosition;

	NSString* tileTag;
	
	CCLabelTTF* label;
	CCSprite* back;
	
	id<TileSpriteDelegateProtocol> manager;
	
}

@property (assign, readwrite, nonatomic) BOOL isOpen;
@property (assign, readwrite, nonatomic) BOOL isLabelVisible;

@property (assign, readwrite, nonatomic) CGPoint tilePosition;
@property (retain, nonatomic) NSString* tileTag;

@property (retain, nonatomic) NSString* fileName;
@property (retain, nonatomic) CCLabelTTF* label;

@property (assign, nonatomic) id<TileSpriteDelegateProtocol> manager;

-(void)showBack;
-(void)showFront;
-(void)flip: (BOOL)showFace;

-(BOOL)tapped;
-(CGPoint)getWinningPositionForTilePos:(CGPoint)pos;

@end
