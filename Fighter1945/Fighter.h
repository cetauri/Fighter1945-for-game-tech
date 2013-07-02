//
//  Fighter.h
//  FighterJoysticMoveExercise
//
//  Created by wannabewize on 6/14/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"
@class BattleFieldLayer;

@interface Fighter : CCSprite {    
    float direction;
	float speed;
	BattleFieldLayer *battleField;
}

-(void)move;

// 전투기 이동에 따라서 백그라운드 스크롤
+(id)fighterWithBackground:(BattleFieldLayer *)bgLayer;
-(BOOL)isCollide:(CCNode *)node onlyContains:(BOOL)contains;

@property float direction, speed;
@property (assign) BattleFieldLayer *battleField;

@end
