//
//  HUDLayer.h
//  Fighter1945
//
//  Created by wannabewize on 6/21/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class BattleFieldLayer;

@interface HudLayer : CCLayer {
	CCSprite *joypad, *joybtn, *fireBtn;
	BOOL isMovingJoybtn;
}

@property (assign) BattleFieldLayer *gameLayer;

@end

