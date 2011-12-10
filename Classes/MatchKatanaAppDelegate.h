//
//  MatchKanaAppDelegate.h
//  MatchKana
//
//  Created by Marin Todorov on 12/29/10.
//  Copyright Marin Todorov 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RootViewController;

@interface MatchKatanaAppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;

@end
