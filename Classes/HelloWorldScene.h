//
//  HelloWorldLayer.h
//  MatchKana
//
//  Created by Marin Todorov on 12/29/10.
//  Copyright Marin Todorov 2010. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"
#import "TrackManager.h"
#import "8TraxConfig.h"
#import "TileSprite.h"

// HelloWorld Layer
@interface MatchGameScene : CCLayer
{
	TrackManager* manager;
	CCMenuItemImage* btnLableVisible;
	CCMenu* gameMenu;
	
//	UIViewController *viewController;
}

@property (retain, nonatomic) TrackManager* manager;
@property (retain, nonatomic) CCMenu* gameMenu;

// returns a Scene that contains the HelloWorld as the only child
+(id) scene;

@end

