//
//  IntroLayer.m
//  Fighter1945
//
//  Created by wannabewize_air on 6/15/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import "IntroLayer.h"
#import "BattleFieldScene.h"
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"
@implementation IntroLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	IntroLayer *layer = [IntroLayer node];
	[scene addChild: layer];
	return scene;
}

-(void)facebook {
    
    NSLog(@"facebook");
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appDelegate openSession:YES];
}

-(void)startGame {
	BattleFieldScene *gameScene = [BattleFieldScene scene];
	CCTransitionMoveInT *transition = [CCTransitionMoveInT transitionWithDuration:0.1 scene:gameScene];
	[[CCDirector sharedDirector] replaceScene:transition];
}

-(void)showCredits {
	// 크레딧 화면으로 전환
}

-(id)init {
	if( (self=[super initWithColor:ccc4(24, 73, 156, 255)])) {
		CGSize winsize = [[CCDirector sharedDirector] winSize];
		
		CCSprite *logo = [CCSprite spriteWithFile:@"logo.png"];
		logo.anchorPoint = CGPointMake(0.5, 0.5);
		logo.position = ccp(winsize.width*0.6, winsize.height*0.75);
		[self addChild:logo];
		
        
		CCMenuItem *item0 = [CCMenuItemFont itemFromString:@"Facebook login" target:self selector:@selector(facebook)];
	
        CCMenuItem *item1 = [CCMenuItemFont itemFromString:@"Start Game" target:self selector:@selector(startGame)];
		CCMenuItemImage	*item2 = [CCMenuItemImage itemFromNormalImage:@"credits_normal.png" selectedImage:@"credits_selected.png" target:self selector:@selector(showCredits)];
        
        item0.isEnabled = YES;
		item1.isEnabled = YES;
		
		CCMenu *menu = [CCMenu menuWithItems:item0, item1, item2, nil];
		[menu alignItemsVerticallyWithPadding:5.0];
		
		menu.anchorPoint = ccp(0.5, 0.5);
		menu.position = ccp(winsize.width/2, winsize.height*0.3);
		[self addChild:menu];
	}
	
	return self;
}

@end
