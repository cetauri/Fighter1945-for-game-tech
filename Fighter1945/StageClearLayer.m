//
//  StageClearLayer.m
//  Fighter1945
//
//  Created by wannabewize on 6/16/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import "StageClearLayer.h"
#import "BattleFieldLayer.h"


@implementation StageClearLayer

@synthesize interval;



+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	StageClearLayer *layer = [StageClearLayer node];
	[scene addChild: layer];
	return scene;
}

-(void)startGame {
	CCTransitionCrossFade *transition = [CCTransitionCrossFade transitionWithDuration:0.3 scene:[BattleFieldLayer scene]];
	[[CCDirector sharedDirector] replaceScene:transition];
}

-(id)init {
	if( (self=[super initWithColor:ccc4(24, 73, 156, 255)])) {
		CGSize winsize = [[CCDirector sharedDirector] winSize];
		
		CCSprite *logo = [CCSprite spriteWithFile:@"logo.png"];
		logo.anchorPoint = CGPointMake(0.5, 0.5);
		logo.position = ccp(winsize.width*0.6, winsize.height*0.75);
		[self addChild:logo];
		
		CCMenuItem *item1 = [CCMenuItemFont itemFromString:@"Start Game" target:self selector:@selector(startGame)];		
		CCMenuItemImage	*item2 = [CCMenuItemImage itemFromNormalImage:@"credits_normal.png" selectedImage:@"credits_selected.png" target:self selector:@selector(doNothing)];
		
		item1.isEnabled = YES;
		
		CCMenu *menu = [CCMenu menuWithItems:item1, item2, nil];
		[menu alignItemsVerticallyWithPadding:5.0];
		
		menu.anchorPoint = ccp(0.5, 0.5);
		menu.position = ccp(winsize.width/2, winsize.height*0.3);
		[self addChild:menu];
	}
	
	return self;
}


@end
