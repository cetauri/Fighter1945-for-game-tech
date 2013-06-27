//
//  HUDLayer.m
//  Fighter1945
//
//  Created by wannabewize on 6/21/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import "HUDLayer.h"
#import "BattleFieldLayer.h"
#import "Fighter.h"

@implementation HudLayer

@synthesize gameLayer;

-(id) init {
	if( (self=[super init])) {	
		self.isTouchEnabled = YES;
		
		CGSize winsize = [[CCDirector sharedDirector] winSize];
		
		joypad = [CCSprite spriteWithFile:@"joypad.png"];
		joypad.position = ccp(70,70);
		[self addChild:joypad];
		
		joybtn = [CCSprite spriteWithFile:@"joybtn.png"];
		joybtn.position = ccp(70,70);
		[self addChild:joybtn];
		
		fireBtn = [CCSprite spriteWithFile:@"joybtn.png"];
		int x = winsize.width - (fireBtn.contentSize.width);
		fireBtn.position = ccp(x,70);
		[self addChild:fireBtn];
	}
	return self;
}



// 조이스틱 이동, 이동에 따라서 비행기의 각도와 속도 계산, 세팅
#define MAX_JOYBTN_DIST (joypad.contentSize.width / 2)
-(void)moveJoybtn:(UITouch *)touch {	
	// 터치 좌표
	CGPoint point = [self convertTouchToNodeSpace:touch];
	
	// 스틱과 터치간의 거리
	float dist = ccpDistance(point, joypad.position);
	if ( dist < MAX_JOYBTN_DIST ) {
		joybtn.position = point;
	}
	
	// 스틱의 포인트로 각도 계산
	CGPoint delta = ccpSub(point, joypad.position);
	float angle = ccpToAngle(delta);
	
	// 스틱과 중심의 거리 정도를 스피드로
	gameLayer.fighter.speed = (int)dist / MAX_JOYBTN_DIST * 5;
	gameLayer.fighter.direction = angle;	
}


// 터치가 조이스틱 영역 내부인지 체크
-(BOOL) isTouchingJoybtn:(UITouch*)touch {
	CGPoint touchPoint = [self convertTouchToNodeSpace:touch];
	return ccpDistance(joybtn.position, touchPoint) < (joybtn.contentSize.width / 2);
}

// 터치가 발사 버튼 터치 영역 내부인지 체크
-(BOOL) isTouchingFireBtn:(UITouch *)touch {
	CGPoint touchPoint = [self convertTouchToNodeSpace:touch];
	return ccpDistance(fireBtn.position, touchPoint) < (fireBtn.contentSize.width / 2);
}

// 멀티 터치 대응 : 조이스틱 터치 코드이면 처리
-(void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in [touches allObjects]) {
		if ( [self isTouchingJoybtn:touch] ) {
			isMovingJoybtn = YES;
		}		
	}
}

// 조이스틱 영역 내부에서 발생한 터치인지 비교, 처리
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in [touches allObjects]) {
		if ( [self isTouchingJoybtn:touch] && YES == isMovingJoybtn ) {
			[self moveJoybtn:touch];
		}		
	}
}

-(void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	for (UITouch *touch in [touches allObjects]) {
		if ( [self isTouchingFireBtn:touch] ) {
			[gameLayer shootTarget];
		} else if ( isMovingJoybtn ) {
			joybtn.position = joypad.position;
			gameLayer.fighter.speed = 0;
			isMovingJoybtn = NO;
		}
	}	
}

@end
