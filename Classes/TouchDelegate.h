//
//  TouchDelegate.h
//  MatchKana
//
//  Created by Marin Todorov on 12/30/10.
//  Copyright 2010 Marin Todorov. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TouchDelegateProtocol

@required
-(void)ccTouchBegan:(CGPoint)location;
-(void)ccTouchMoved:(CGPoint)translation;

@end