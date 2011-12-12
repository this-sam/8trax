//
//  HelloWorldLayer.m
//  MatchKana
//
//  Created by Marin Todorov on 12/29/10.
//  Copyright Marin Todorov 2010. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "InfoScreen.h"

//private methods
@interface MatchGameScene(Private)

-(void)createTileSet;
-(void)createMenu;
-(void)createUI;

@end

// HelloWorld implementation
@implementation MatchGameScene

@synthesize manager, gameMenu;

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MatchGameScene *layer = [MatchGameScene node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
	// always call "super" init
	// Apple recommends to re-assign "self" with the "super" return value
	if( (self=[super init] )) {
		
		//self.isTouchEnabled = YES;

		// ask director the the window size
		CGSize size = [[CCDirector sharedDirector] winSize];

		//set the background
		CCSprite* bg = [CCSprite spriteWithFile:@"background.png"];
		bg.position = ccp(size.width/2,size.height/2);
		[self addChild: bg ];
		
		// initialize the manager
		self.manager = [[[TrackManager alloc] init] autorelease];

		//create the screen elements
		[self createTileSet];
		//[self createMenu];
		//[self createUI];
        //dispatch loop manager    
        
        NSLog(@"Dispatching loop manager...");
        [NSThread detachNewThreadSelector:@selector(startLooping) toTarget:[Looper class] withObject:nil];
	}
	
	return self;
}

-(void)createTileSet
{
	// ask director the the window size
    CGSize size = [[CCDirector sharedDirector] winSize];
	NSLog(@"Window Size: %0.2f x %0.2f", size.width, size.height);
    
    int left_margin = (size.width - kTileWidth*kTileSetWidth)/2;
    int bottom_margin = (size.height - kTileHeight*kTileSetHeight)/5*2;
    
	self.manager.tileSet.position = ccp(left_margin, bottom_margin);
	[self addChild:self.manager.tileSet];
	
}

-(void)createMenu
{
	CCMenuItemImage* btnInfo = [CCMenuItemImage itemFromNormalImage:@"btnInfo.png" selectedImage:@"btnInfo.png" target:self selector:@selector(btnInfoTapped:)];
	btnInfo.position = ccp(28,16);
	
	btnLableVisible = [CCMenuItemImage itemFromNormalImage:@"btnIsLabelVisible.png" selectedImage:@"btnIsLabelVisible.png" target:self selector:@selector(btnLableVisibleTapped:)];
	btnLableVisible.position = ccp(263,16);
	btnLableVisible.tag = 0;
	
	gameMenu = [CCMenu menuWithItems:btnInfo, btnLableVisible ,nil];
	gameMenu.position = ccp(0,0);
	
	[self addChild: gameMenu];
	
}

-(void)createUI
{
	// ask director the the window size
	CGSize size = [[CCDirector sharedDirector] winSize];

	//win text label
	CCSprite* winText = [CCSprite spriteWithFile: kWinTextFilename];
	winText.position = ccp(size.width/2, 65);
	[winText setOpacity: 0.0];
	[self addChild: winText];
	self.manager.winText = winText;
	
	//win menu
	CCMenuItemImage* btnAgain = [CCMenuItemImage itemFromNormalImage:kNewGameTextFilename selectedImage:kNewGameTextFilename target:self selector:@selector(newGame)];
	CCMenu* winMenu = [CCMenu menuWithItems:btnAgain, nil];
	winMenu.position = ccp(size.width/2, 65);
	winMenu.visible = NO;
	[self addChild: winMenu];
	self.manager.menuWin = winMenu;
}

-(void)newGame
{

	[self.manager.tileSet removeAllChildrenWithCleanup:YES];
	self.manager.tileSet = nil;

	[self removeChild:self.manager.tileSet cleanup:YES];
	
	
	[self.manager unloadTileSet];
	
	[self.manager load];
	[self createTileSet];

	self.manager.menuWin.visible = NO;
}

-(void)btnInfoTapped:(id)sender
{
	[[CCDirector sharedDirector] pushScene: [InfoScreen scene]];
}

-(void)btnLableVisibleTapped:(id)sender
{
	[self performSelector:@selector(toggleLabelBtnImage) withObject:nil afterDelay:0.1];
}

-(void)toggleLabelBtnImage
{
	int isVisibleSelected = btnLableVisible.tag;
	
	[gameMenu removeChild:btnLableVisible cleanup:NO];

	if (isVisibleSelected==0) {
		btnLableVisible = [CCMenuItemImage itemFromNormalImage:@"btnIsLabelVisibleSelected.png" selectedImage:@"btnIsLabelVisibleSelected.png" target:self selector:@selector(btnLableVisibleTapped:)];
		btnLableVisible.tag =1;
	} else {
		btnLableVisible = [CCMenuItemImage itemFromNormalImage:@"btnIsLabelVisible.png" selectedImage:@"btnIsLabelVisible.png" target:self selector:@selector(btnLableVisibleTapped:)];
		btnLableVisible.tag =0;
	}

	btnLableVisible.position = ccp(263,16);
	[gameMenu addChild: btnLableVisible];
	
	[self.manager toggleLabelVisibility];	
}

- (void) dealloc
{
	[gameMenu removeChild:btnLableVisible cleanup:NO];
	
	self.gameMenu = nil;
	self.manager = nil;
	
	[super dealloc];
}
@end
