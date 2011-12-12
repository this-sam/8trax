//
//  TileSprite.m
//  MatchKana
//
//  Created by Marin Todorov on 12/29/10.
//  Copyright 2010 Marin Todorov. All rights reserved.
//

#import "TileSprite.h"


@implementation TileSprite

@synthesize isOpen, isLabelVisible;
@synthesize tilePosition, tileTag, fileName;
@synthesize label;
@synthesize manager;

-(id)init
{
	self = [super init];
	if (self != nil) {

		self.tileTag = nil;
		self.fileName = nil;
		self.isOpen = NO;
		back = nil;
	}
	return self;
}

-(void)setTilePosition:(CGPoint)pos
{
	tilePosition = pos;
	
	//set also the position itself
	self.position = ccp(
		pos.x * kTileWidth + pos.x * kTileMarginRight+ kTileWidth/2,
		pos.y * kTileHeight + pos.y * kTileMarginBottom + kTileHeight/2
	);
	
}

-(void)setTileTag:(NSString*)tag
{
	tileTag = tag;
	
	self.label = [CCLabelTTF labelWithString:tileTag fontName:@"Courier New" fontSize:14];
	self.label.color = ccc3(128,0,0);
	self.label.position = ccp( kTileWidth/2, 20 );
	self.label.visible = self.isLabelVisible;
	
	[self addChild: self.label];
}

-(void)setIsLabelVisible:(BOOL)isVisible
{
	isLabelVisible = isVisible;
	self.label.visible = isVisible;
}

- (void) flip: (BOOL) showFace
{
	float d = 0;
	
	id firstAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:0 deltaAngleX:0];
	id secondAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:270 deltaAngleZ:90 angleX:0 deltaAngleX:0];
	
	[self runAction: [CCSequence actions:
					  firstAction,
					  [CardFlipAction actionWithCard: self],
					  secondAction,
					  [CCCallFunc actionWithTarget:self selector:@selector(didFlip)],
					  nil]];
}

-(void)didFlip
{
	self.isOpen = !self.isOpen;
	
	if (self.isOpen == YES) {
		//let the manager know the tile did open
		[self.manager performSelector:@selector(didOpenTile:) withObject:self];
	}
}

-(void)showBack
{
	if (back==nil) {
		back = [[CCSprite spriteWithFile: kTileBackName] retain];
		back.position = ccp(
			self.contentSize.width/2,
			self.contentSize.height/2				
		);
		[self addChild: back];
	}

#if TARGET_IPHONE_SIMULATOR
	//back.opacity = 130;
#endif

	back.visible = YES;
}

-(void)showFront
{
	back.visible = NO;
}

-(BOOL)tapped
{
	DLog(@"tap on [%.f,%.f]", tilePosition.x, tilePosition.y);
	
	//if (self.isOpen == NO) {
    [self flip: !self.isOpen];
	return YES;
	//}
	
	//return NO;
}

-(CGPoint)getWinningPositionForTilePos:(CGPoint)pos
{
	int odd = (int)pos.x % 2;
	if (odd==0) {
		return ccp(
				   pos.x * kTileWidth + (pos.x+1) * kTileMarginRight+ kTileWidth/2,
				   pos.y * kTileHeight + pos.y * kTileMarginBottom + kTileHeight/2
				   );
		
	} else {
		return ccp(
				   pos.x * kTileWidth + (pos.x-2) * kTileMarginRight+ kTileWidth/2,
				   pos.y * kTileHeight + pos.y * kTileMarginBottom + kTileHeight/2
				   );
		
	}
}

-(void)dealloc
{
	[self removeAllChildrenWithCleanup:YES];
	
	self.tileTag = nil;
	self.fileName = nil;
	self.label = nil;
	
	[super dealloc];
}

@end
