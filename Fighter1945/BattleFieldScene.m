//
//  BattleFieldScene.m
//  Fighter1945
//
//  Created by wannabewize on 6/16/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import "BattleFieldScene.h"
#import "BattleFieldLayer.h"
#import "Fighter.h"
#import "HUDLayer.h"



@implementation BattleFieldScene


+(id)scene {
	BattleFieldScene *scene = [[[BattleFieldScene alloc] init] autorelease];
	return scene;
}

-(id)init {
	self = [super init];
	if ( self ) {
		BattleFieldLayer *gameLayer = [[BattleFieldLayer alloc] init];
		[self addChild:gameLayer z:1];
		[gameLayer release];
		
		HudLayer *hudLayer = [[HudLayer alloc] init];
		hudLayer.gameLayer = gameLayer;
		[self addChild:hudLayer z:2];
		[hudLayer release];
		
//		CGSize winsize = [[CCDirector sharedDirector] winSize];						  
//		CGRect movingArea;
//		movingArea.origin = ccp(winsize.width * 0.2, winsize.height * 0.2);
//		movingArea.size = CGSizeMake(winsize.width * 0.6, winsize.height * 0.6);
		
	}
	return self;
}


@end
