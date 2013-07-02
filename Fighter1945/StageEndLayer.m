//
//  StageClearLayer.m
//  Fighter1945
//
//  Created by wannabewize on 6/16/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import "StageEndLayer.h"
#import "BattleFieldLayer.h"
#import "IntroLayer.h"


@implementation StageEndLayer

@synthesize win;

+(CCScene *) sceneWithResult:(BOOL)isWin {
	CCScene *scene = [CCScene node];
	StageEndLayer *layer = [StageEndLayer node];
	layer.win = isWin;
	[scene addChild: layer];
	return scene;
}

- (void)mainMenu {
	CCScene *menu = [IntroLayer scene];
	CCTransitionMoveInT *transition = [CCTransitionMoveInT transitionWithDuration:0.1f scene:menu];
	[[CCDirector sharedDirector] replaceScene:transition];
}

-(void)replay {
	CCScene *gameScene = [BattleFieldLayer scene];
	CCTransitionMoveInT *transition = [CCTransitionMoveInT transitionWithDuration:0.1 scene:gameScene];
	[[CCDirector sharedDirector] replaceScene:transition];	
}


-(id)init {
	if( (self=[super initWithColor:ccc4(24, 73, 156, 255)])) {
		CGSize winsize = [[CCDirector sharedDirector] winSize];
		
		NSString *text;
		if ( win ) {
			text = @"You Win";
		} else {
			text = @"You Lose";
		}
		
		CCLabelTTF *label = [CCLabelTTF labelWithString:text fontName:@"Marker Felt" fontSize:50];
		label.position = ccp(winsize.width/2, winsize.height*3/4);
		[self addChild:label];

		
		CCMenuItem *item1 = [CCMenuItemFont itemFromString:@"Menu" target:self selector:@selector(mainMenu)];
		CCMenuItem *item2 = [CCMenuItemFont itemFromString:@"Replay" target:self selector:@selector(replay)];		
		
		CCMenu *menu = [CCMenu menuWithItems:item1, item2, nil];
		[menu alignItemsVerticallyWithPadding:5.0f];
		menu.anchorPoint = ccp(0.5, 0.5);
		menu.position = ccp(winsize.width/2, winsize.height*0.3);
		
		[self addChild:menu];
        
	}
	
	return self;
}


@end
