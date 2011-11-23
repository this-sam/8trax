//
//  TileSpriteDelegateProtocol.h
//  MatchKana
//
//  Created by Marin Todorov on 6/2/11.
//  Copyright 2011 Marin Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TileSprite;

@protocol TileSpriteDelegateProtocol <NSObject> 

-(void)didOpenTile:(TileSprite*)tile;

@end