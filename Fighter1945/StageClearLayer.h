//
//  StageClearLayer.h
//  Fighter1945
//
//  Created by wannabewize on 6/16/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface StageClearLayer : CCLayerColor {
	NSTimeInterval interval;
    
}

@property NSTimeInterval interval;

-(void)startGame;
+(CCScene *) scene;

@end
