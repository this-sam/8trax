//
//  MatchManager.m
//  MatchKana
//
//  Created by Marin Todorov on 12/29/10.
//  Copyright 2010 Marin Todorov. All rights reserved.
//

#import "TrackManager.h"
#import "NSMutableArray+Shuffle.h"

@interface TrackManager(Private)

-(void)removeMatchingTiles:(NSArray*)tiles;

@end


@implementation TrackManager

@synthesize tileNames;
@synthesize openTiles, tileSet;
@synthesize tileBack, tileFront, numOpenTiles;
@synthesize winText, menuWin;

-(id)init
{
	self = [super init];
	if (self != nil) {
		//initialization
		self.tileNames = nil;
		
		[self load];
		self.openTiles = [NSMutableArray arrayWithCapacity:kTileSetHeight];
		self.tileBack = [CCSprite spriteWithFile: kTileBackName ];
        self.tileFront = [CCSprite spriteWithFile: kTileFrontName];
		
		//audio
		[[SimpleAudioEngine sharedEngine] preloadEffect:kMatchAudioFilename];
		[[SimpleAudioEngine sharedEngine] preloadEffect:kWinAudioFilename];
		
		//start dispatching touches
		dispatchTouches = YES;
	}
	
	return self;
}

-(void)loadTileNames
{
	NSString* fileNamePattern = [NSString stringWithFormat:@"-%@.png", kSet1Name];
	NSMutableArray* result = [NSMutableArray array];
	NSFileManager* fileManager = [NSFileManager defaultManager];
	
	for (NSString* fileName in [fileManager contentsOfDirectoryAtPath: [[NSBundle mainBundle] resourcePath] error:nil]){
		if ( [fileName rangeOfString:fileNamePattern].location != NSNotFound  ) {

			[result addObject: 
			 //remove the extra info from the filename
			 [fileName stringByReplacingOccurrencesOfString:fileNamePattern withString:@""]
			 ];
		}
	}
	
	self.tileNames = [NSArray arrayWithArray: result];
	//DLog(@"tile set: %@", self.tileNames);
}

-(void)load
{
	//load the names of the tiles
	if (self.tileNames == nil) {
		[self loadTileNames];
	}
	
	//load the sprites and randomize the board
	
	int count = kTileSetWidth * kTileSetHeight;
	
	NSMutableArray*	names1 = [NSMutableArray arrayWithCapacity:count];
	NSMutableArray* result = [NSMutableArray arrayWithCapacity:count];
	
	while ([names1 count]<count/2) {
		//load tile names
		int nr = arc4random() % [tileNames count];
		NSString* tileTag = [tileNames objectAtIndex:nr];
		NSString* name1 = [NSString stringWithFormat:@"%@-%@.png", tileTag, kSet1Name ];
		
		if ( ! [names1 containsObject: name1] ) {
			
			[names1 addObject: name1];

			TileSprite* tile = [TileSprite itemFromNormalImage:name1 selectedImage:name1 target:self selector:@selector(dispatchTileTap:)];
			tile.tileTag = tileTag;
			tile.fileName = name1;
			tile.manager = self;
			tile.tag = [result count];
			tile.isLabelVisible = isTileLabelVisible;
			[result addObject: tile];
			
			NSString* name2 = [NSString stringWithFormat:@"%@-%@.png", tileTag, kSet2Name ];
			
			TileSprite* tile2 = [TileSprite itemFromNormalImage:name2 selectedImage:name2 target:self selector:@selector(dispatchTileTap:)];
			tile2.tileTag = tileTag;
			tile2.fileName = name2;
			tile2.manager = self;
			tile2.tag = [result count];
			tile2.isLabelVisible = isTileLabelVisible;
			[result addObject: tile2];
		}
	}

	self.tileSet = [CCMenu menuWithItems:nil];
	
	for (int i=0;i<kTileSetWidth;i++) {
		for (int j=0;j<kTileSetHeight;j++) {
			TileSprite* tile = (TileSprite*)[result objectAtIndex: i*kTileSetWidth + j];
			tile.tilePosition = ccp(i,j);
			[self.tileSet addChild:tile z:1000];
			[tile showBack];
		}
	}

	self.numOpenTiles = 0;
	
	//DLog(@"selection: %@", self.sprites );
}

-(void)dispatchTileTap:(id)sender
{
	if (dispatchTouches==NO) return;
	
	/*if ([self.openTiles count]>1) {
		//don't allow more than 2 to be open at the same time
		return;
	}*/
	
	//if the tile swallows the touch stop dispatching touches
	if ([(TileSprite*)sender tapped]) {
		//dispatchTouches = NO;
	}
}

-(void)didOpenTile:(TileSprite*)tile
{
	[self.openTiles addObject: tile];
	
	/*if ([self.openTiles count]>1) {
		TileSprite* tile1 = [self.openTiles objectAtIndex:0];
		
		//check if the open tiles match
		if ([tile.tileTag compare: tile1.tileTag]==NSOrderedSame) {
			
			//the tiles match
			[self removeMatchingTiles:[NSArray arrayWithObjects:tile,tile1,nil]];
			
		} else {
			//sorry, close the tiles
			[tile performSelector:@selector(flip:) withObject:nil afterDelay:1];
			[tile1 performSelector:@selector(flip:) withObject:nil afterDelay:1];
			[self performSelector:@selector(didTilesClose) withObject:nil afterDelay:1.1];
		}
	}*/
	
	dispatchTouches = YES;
}

-(void)didTilesClose
{
	//clear the open tiles
	[self.openTiles removeAllObjects];
}

-(void)removeMatchingTiles:(NSArray*)tiles
{
	//make sound
	[[SimpleAudioEngine sharedEngine] setEffectsVolume: 0.5 ];
	[[SimpleAudioEngine sharedEngine] playEffect:kMatchAudioFilename];
	
	//remove the tiles
	for (TileSprite* tile in tiles) { 
		//remove the tiles from the screen
		[self.tileSet reorderChild:tile z:10];
		
		[tile runAction:
		 [CCSequence actions: 
			[CCFadeTo actionWithDuration:0.3 opacity:180],
			[CCScaleTo actionWithDuration:0.3 scale:0.85],
			nil
		  ]
		 ];
	}
	
	[self.openTiles removeAllObjects];
	
	self.numOpenTiles += 2;
	
	if (self.numOpenTiles == kTileSetWidth * kTileSetHeight) {
		//make sound
		[[SimpleAudioEngine sharedEngine] playEffect:kWinAudioFilename];
		
		//run the winning sequence
		[self.winText runAction:
			[CCSequence actions:
				[CCFadeIn actionWithDuration:0.5],
				[CCFadeTo actionWithDuration:3.0 opacity:255],
				[CCFadeOut actionWithDuration:0.5],
				[CCCallFunc actionWithTarget:self selector:@selector(showNewGameMenu)],
				nil
			 ]
		 ];
		
		//order the tiles
		[self showWinAnimation];
	}
}

-(void)showNewGameMenu
{
	//show the new menu
	self.menuWin.visible = YES;
	//self.menuWin.opacity = 245;
	
	[self.menuWin runAction:
		[CCRepeatForever actionWithAction:
			[CCSequence actions:
				[CCFadeTo actionWithDuration:0.5 opacity:130],
				[CCFadeTo actionWithDuration:0.3 opacity: 240],
				nil
			 ]
		 ]
	 ];
	
}

-(void)unloadTileSet
{
	numOpenTiles = 0;
	
	//reload the tile set
	[self.openTiles removeAllObjects];
	self.openTiles = [NSMutableArray arrayWithCapacity:2];
}

-(void)showWinAnimation
{
	//
	for (int i=0;i<kTileSetWidth;i++) {
		for (int j=0;j<kTileSetHeight;j++) {
			TileSprite* tile = (TileSprite*)[self.tileSet getChildByTag: i*kTileSetWidth + j];
			tile.isLabelVisible = YES;
			[tile runAction:
				[CCSequence actions:
					[CCFadeTo actionWithDuration:0.1 opacity:120],
					[CCMoveTo actionWithDuration:0.3 position: [tile getWinningPositionForTilePos:ccp(j,i)]],
					[CCFadeTo actionWithDuration:0.1 opacity:240],
					nil
				 ]
			 ];
		}
	}
}

-(void)toggleLabelVisibility
{
	isTileLabelVisible = !isTileLabelVisible;
	for (TileSprite* tile in self.tileSet.children) {
		tile.isLabelVisible = isTileLabelVisible;
	}
}

-(void)setDispatchTouches:(BOOL)does
{
	dispatchTouches = does;
}

-(void)dealloc
{
    self.tileNames = nil;
    self.openTiles = nil;
    self.tileSet = nil;
    
	self.tileBack = nil;
	self.menuWin = nil;
	self.winText = nil;
	
	[super dealloc];
}

@end