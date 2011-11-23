//
//  ImageSwapAction.m
//  MatchKana
//
//  Created by Marin Todorov on 12/29/10.
//  Copyright 2010 Marin Todorov. All rights reserved.
//

#import "CardFlipAction.h"

// http://www.cocos2d-iphone.org/forum/profile/6184
// ImageSwapAction

@implementation CardFlipAction
@synthesize card;

+ (id) actionWithCard: (TileSprite*) whichCard
{
	return [[[self alloc] initWithCard: whichCard] autorelease];
}

- (id) initWithCard: (TileSprite*) whichCard
{
	if( (self=[super init]) )
	{
		card = whichCard;
		return self;
	}
	return nil;
}

- (float) duration
{
	return 0;
}

-(void) update: (ccTime) dt
{
	if (card.isOpen == YES) {
		[card showBack];
	} else {
		[card showFront];
	}
}

-(id) copyWithZone: (NSZone*) zone
{
	return [[[self class] allocWithZone: zone] initWithCard: card];
}

@end