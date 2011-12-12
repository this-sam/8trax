//
//  Looper.m
//  8trax
//
//  Created by CSCrew on 12/11/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "Looper.h"

@implementation Looper
+(void)startLooping{
    //loop through the arrays, doin' shit.
    NSDate *start = [NSDate date];
    [[SimpleAudioEngine sharedEngine] preloadEffect:kSample0];	
    [[SimpleAudioEngine sharedEngine] preloadEffect:kSample1];	
    [[SimpleAudioEngine sharedEngine] preloadEffect:kSample2];	
    [[SimpleAudioEngine sharedEngine] setEffectsVolume: 0.5 ];
	int beatIndex = 0;
    
    //calculate how long each 16th note lasts:
    float beatInterval = (60./kGlobalBPM)/4;  //MOVE THIS INSIDE LOOP ONCE BMP IS DYNAMIC
    while (true){
        //time interval is always negative?
        NSTimeInterval timeInterval = (0-1)*[start timeIntervalSinceNow];
                    
        if (timeInterval >= beatInterval){
            start = [NSDate date];
            NSLog(@"I have been called!");
            
            //for             
            [[SimpleAudioEngine sharedEngine] playEffect:kSample1];
            
            if(beatIndex%4==0){
                [[SimpleAudioEngine sharedEngine] playEffect:kSample0];
            }
            if(beatIndex%6==0)
            [[SimpleAudioEngine sharedEngine] playEffect:kSample2];
            beatIndex++;
        }
        
        
    }
}


@end
