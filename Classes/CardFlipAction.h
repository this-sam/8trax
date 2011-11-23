//
//  ImageSwapAction.h
//  MatchKana
//
//  Created by Marin Todorov on 12/29/10.
//  Copyright 2010 Marin Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TileSprite.h"

@class TileSprite;

@interface CardFlipAction : CCAction {
	TileSprite* card;
}

@property (retain, nonatomic) TileSprite* card;

+ (id) actionWithCard: (TileSprite*) whichCard;
- (id) initWithCard: (TileSprite*) whichCard;

@end
