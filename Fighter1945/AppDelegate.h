//
//  AppDelegate.h
//  Fighter1945
//
//  Created by wannabewize_air on 6/14/11.
//  Copyright iNEED 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <FacebookSDK/FacebookSDK.h>
@class RootViewController;

@interface AppDelegate : NSObject <UIApplicationDelegate> {
	UIWindow			*window;
	RootViewController	*viewController;
}

@property (nonatomic, retain) UIWindow *window;
- (void)openSession:(BOOL)allowLoginUI;

@end
