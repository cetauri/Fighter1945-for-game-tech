//
//  Fighter.m
//  FighterJoysticMoveExercise
//
//  Created by wannabewize on 6/14/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import "Fighter.h"
#import "BattleFieldLayer.h"
#import "SimpleAudioEngine.h"


@implementation Fighter

@synthesize direction, speed;
@synthesize battleField;

+(id)fighterWithBackground:(BattleFieldLayer *)bgLayer {
	Fighter *fighter = [super spriteWithFile:@"fighter.png"];
	fighter.battleField = bgLayer;
	return fighter;
}

-(void)move {
	if ( speed == 0 )
		return;
	
	// 속도와 방향을 계산
	CGPoint dxdy = ccpMult(ccpForAngle(direction), speed);
	// 현 위치에 속도와 방향을 계산한 만큼 더함
	CGPoint newPosition = ccpAdd(self.position, dxdy);
	
	CGSize winsize = [[CCDirector sharedDirector] winSize];
	CGRect movingArea;
	movingArea.origin = ccp(winsize.width * 0.2, winsize.height * 0.2);
	movingArea.size = CGSizeMake(winsize.width * 0.6, winsize.height * 0.6);
	
	if ( CGRectContainsPoint(movingArea, newPosition) ) {
		self.position = newPosition;
	}
	else {
		[battleField scrollBy:ccpNeg(dxdy) withSpeed:speed];
	}
		
}
// 충돌 체크 - 일부 겹치는 것과 완전히 포함 관계를 체크 - 단 anchorPoint=(0.5,0.5)
-(BOOL)isCollide:(CCNode *)node onlyContains:(BOOL)contains {
	CGRect rectSelf;
	rectSelf.origin = ccpAdd(self.position, ccpMult(ccpFromSize(self.contentSize), -0.5));
	rectSelf.size = self.contentSize;
	
	CGRect rectOther;
	rectOther.origin = ccpAdd(node.position, ccpMult(ccpFromSize(node.contentSize), -0.5));
	rectOther.size = node.contentSize;
	
	if ( contains )
		return CGRectContainsRect(rectSelf, rectOther); // 포함될때만..
	else {
		// 두 스프라이트 간의 거리가 너비,높이의 70% 정도 이내일 때
		CGFloat dist = ccpDistance(self.position, node.position);
		return ( dist < ( self.contentSize.width * 0.7 ) || dist < ( self.contentSize.height * 0.7 ) );
	}
}

-(void)explode:(CCAnimation *)explosionAni {
//	[self stopAllActions];
	
	id explosionAction = [CCAnimate actionWithAnimation:explosionAni];
	id removeAction = [CCCallFuncN actionWithTarget:battleField selector:@selector(spriteMoveFinished:)];
	[self runAction:[CCSequence actions:explosionAction, removeAction, nil]];
	[[SimpleAudioEngine sharedEngine] playEffect:@"explosion.aif"];
}
@end