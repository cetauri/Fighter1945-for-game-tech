//
//  IntroLayer.h
//  Fighter1945
//
//  Created by wannabewize_air on 6/15/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface IntroLayer : CCLayerColor {
    
}

-(void)showCredits;
-(void)startGame;

+(CCScene *) scene;

@end
