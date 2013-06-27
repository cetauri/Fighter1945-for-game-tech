//
//  Fighter.m
//  FighterJoysticMoveExercise
//
//  Created by wannabewize on 6/14/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import "Fighter.h"
#import "BattleFieldLayer.h"


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

@end