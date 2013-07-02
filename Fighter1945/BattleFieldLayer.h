//
//  HelloWorldLayer.h
//  FighterJoysticMoveExercise
//
//  Created by wannabewize on 6/14/11.
//  Copyright iNEED 2011. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

@class Fighter;

@interface BattleFieldLayer : CCLayerColor {
	CCSprite *joypad, *joybtn, *fireBtn;
	BOOL isMovingJoybtn;
	
	Fighter *fighter;	
	
	// 총알과 적의 스프라이트 저장을 위한 배열
	NSMutableArray *bullets, *enemies;
	
	// 폭발 효과를 위한 애니메이션
	CCAnimation *explosionAni;
	
	// 배경을 위한 Node
	CCLayer *bgLayer;
	CCLayerColor *backgroundLayer;
	CCParallaxNode *voidNode;	
	CGPoint backgroundNodeOffset;
    int score;
}

+(CCScene *) scene;

-(void)scrollBy:(CGPoint)amount withSpeed:(int)speed;
-(void)shootTarget;

@property (retain) Fighter *fighter;

@end
