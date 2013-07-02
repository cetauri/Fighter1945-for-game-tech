//
//  StageClearLayer.h
//  Fighter1945
//
//  Created by wannabewize on 6/16/11.
//  Copyright 2011 iNEED. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface StageEndLayer : CCLayerColor {
	BOOL win;
    
}

@property BOOL win;

+(CCScene *) sceneWithResult:(BOOL)isWin;

@end
