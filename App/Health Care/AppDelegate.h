//
//  AppDelegate.h
//  Health Care
//
//  Created by Midnight.Works iMac on 10/4/16.
//  Copyright © 2016 TUSK.ONE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
- (void)registerForRemoteNotificationsWithUserId:(NSString *)userId ;
@property (nonatomic,strong)  BaseViewController *currentViewController;
@end

