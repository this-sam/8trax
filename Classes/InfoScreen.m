//
//  HiraganaScreen.m
//  MatchKana
//
//  Created by Marin Todorov on 12/30/10.
//  Copyright 2010 Marin Todorov. All rights reserved.
//

#import "InfoScreen.h"


@implementation InfoScreen

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	InfoScreen *layer = [InfoScreen node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init] )) {
		//add the screen background image
		CCSprite* flyer = [CCSprite spriteWithFile: @"InfoScreen.png"];
		flyer.anchorPoint = ccp(0,0);
		flyer.position = ccp(0,0);
		[self addChild:flyer];
		
		//add the menu
		CCMenuItemImage* backItem = [CCMenuItemImage itemFromNormalImage:@"menuBackImage.png" selectedImage:@"menuBackImage.png" target:self selector:@selector(btnBackTapped:)];
		
		CCMenu* menuBack = [CCMenu menuWithItems:backItem,nil];
		menuBack.position = ccp(160, 12);
		[self addChild: menuBack];

	}
	
	return self;
}

-(void)btnBackTapped:(id)sender
{
	[[CCDirector sharedDirector] popScene];
}

@end
